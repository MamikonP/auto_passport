package com.example.auto_passport

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.os.Bundle
import android.text.TextUtils
import android.util.Size
import android.util.TypedValue
import android.view.Gravity
import android.view.HapticFeedbackConstants
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.camera.core.Camera
import androidx.camera.core.CameraSelector
import androidx.camera.core.FocusMeteringAction
import androidx.camera.core.ImageAnalysis
import androidx.camera.core.ImageProxy
import androidx.camera.core.Preview
import androidx.camera.core.UseCaseGroup
import androidx.camera.core.resolutionselector.AspectRatioStrategy
import androidx.camera.core.resolutionselector.ResolutionSelector
import androidx.camera.core.resolutionselector.ResolutionStrategy
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.camera.view.PreviewView
import androidx.core.content.ContextCompat
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import kotlin.math.abs
import kotlin.math.max

class NativeVinScannerActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_VIN = "extra_vin"
        const val EXTRA_LINES = "extra_lines"
        const val EXTRA_FULL_TEXT = "extra_full_text"

        private val LABEL_WORDS_REGEX = Regex("\\b(VIN|CHASSIS|FRAME|NO|NUMBER)\\b")
        private val NON_ALPHANUM_REGEX = Regex("[^A-Z0-9\\s]")
        private val WHITESPACE_REGEX = Regex("\\s+")
        private val ISO_VIN_REGEX = Regex("^[A-HJ-NPR-Z0-9]{17}$")
        private val HAS_LETTER_REGEX = Regex("[A-HJ-NPR-Z]")
        private val HAS_DIGIT_REGEX = Regex("[0-9]")

        fun extractIsoVin(lines: List<String>): String? {
            for (rawLine in lines) {
                val cleaned = rawLine
                    .uppercase()
                    .replace(LABEL_WORDS_REGEX, " ")
                    .replace(NON_ALPHANUM_REGEX, " ")

                val tokens = cleaned.split(WHITESPACE_REGEX).filter { it.isNotEmpty() }
                val candidates = LinkedHashSet<String>()
                candidates.addAll(tokens)

                // Also check concatenated tokens on the same line in case OCR inserted a space inside the 17-char VIN
                val joined = tokens.joinToString("")
                if (joined.length >= 17) {
                    for (i in 0..(joined.length - 17)) {
                        candidates.add(joined.substring(i, i + 17))
                    }
                }

                for (token in candidates) {
                    if (token.length == 17) {
                        val normalized = token
                            .replace('O', '0')
                            .replace('I', '1')
                            .replace('Q', '0')

                        if (ISO_VIN_REGEX.matches(normalized) &&
                            HAS_LETTER_REGEX.containsMatchIn(normalized) &&
                            HAS_DIGIT_REGEX.containsMatchIn(normalized)
                        ) {
                            return normalized
                        }
                    }
                }
            }
            return null
        }
    }

    private lateinit var previewView: PreviewView
    private lateinit var reticleView: View
    private lateinit var reticleBorder: GradientDrawable
    private lateinit var detectedCandidateButton: Button
    private lateinit var cameraExecutor: ExecutorService

    private var camera: Camera? = null
    private var isTorchOn = false
    @Volatile
    private var hasCompleted = false
    private var lastCandidateVin: String? = null
    private var candidateHitCount = 0
    private var latestRecognizedLines: ArrayList<String> = arrayListOf()

    private val recognizer by lazy {
        TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        cameraExecutor = Executors.newSingleThreadExecutor()
        setupUI()
        startCamera()
    }

    override fun onDestroy() {
        super.onDestroy()
        cameraExecutor.shutdown()
        recognizer.close()
    }

    private fun dp(value: Int): Int {
        return TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            value.toFloat(),
            resources.displayMetrics
        ).toInt()
    }

    private fun getStatusBarHeight(): Int {
        val resourceId = resources.getIdentifier("status_bar_height", "dimen", "android")
        return if (resourceId > 0) resources.getDimensionPixelSize(resourceId) else dp(28)
    }

    @SuppressLint("ClickableViewAccessibility")
    private fun setupUI() {
        val root = FrameLayout(this).apply {
            setBackgroundColor(Color.BLACK)
            layoutParams = ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
        }

        previewView = PreviewView(this).apply {
            layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
            )
            scaleType = PreviewView.ScaleType.FILL_CENTER
        }
        root.addView(previewView)

        // Tap-to-focus on preview, returning focus to center reticle after 3 seconds
        previewView.setOnTouchListener { _, event ->
            if (event.action == MotionEvent.ACTION_UP) {
                val factory = previewView.meteringPointFactory
                val point = factory.createPoint(event.x, event.y)
                val action = FocusMeteringAction.Builder(
                    point,
                    FocusMeteringAction.FLAG_AF or FocusMeteringAction.FLAG_AE
                )
                    .setAutoCancelDuration(3, TimeUnit.SECONDS)
                    .build()
                camera?.cameraControl?.startFocusAndMetering(action)
                previewView.postDelayed({ focusOnReticleCenter() }, 3200)
            }
            true
        }

        val initialTopInset = getStatusBarHeight()

        // Top Bar using horizontal LinearLayout so back button, title, and Light action never overflow
        val topBar = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
            setBackgroundColor(Color.parseColor("#99000000"))
            setPadding(dp(12), initialTopInset + dp(10), dp(12), dp(12))
            layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT,
                Gravity.TOP
            )
        }

        ViewCompat.setOnApplyWindowInsetsListener(topBar) { view, windowInsets ->
            val insets = windowInsets.getInsets(
                WindowInsetsCompat.Type.systemBars() or WindowInsetsCompat.Type.displayCutout()
            )
            val topPadding = max(insets.top, initialTopInset) + dp(10)
            view.setPadding(
                max(insets.left, dp(12)),
                topPadding,
                max(insets.right, dp(12)),
                dp(12)
            )
            windowInsets
        }

        val cancelButton = TextView(this).apply {
            text = "✕ Cancel"
            setTextColor(Color.WHITE)
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 14f)
            setTypeface(typeface, Typeface.BOLD)
            isSingleLine = true
            setPadding(dp(4), dp(6), dp(8), dp(6))
            setOnClickListener { finishCancelled() }
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
        }
        topBar.addView(cancelButton)

        val titleLabel = TextView(this).apply {
            text = "Scan 17-Digit VIN"
            setTextColor(Color.WHITE)
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 15f)
            setTypeface(typeface, Typeface.BOLD)
            isSingleLine = true
            ellipsize = TextUtils.TruncateAt.END
            gravity = Gravity.CENTER
            setPadding(dp(8), dp(6), dp(8), dp(6))
            layoutParams = LinearLayout.LayoutParams(
                0,
                LinearLayout.LayoutParams.WRAP_CONTENT,
                1f
            )
        }
        topBar.addView(titleLabel)

        val torchButton = TextView(this).apply {
            text = "⚡ Light"
            setTextColor(Color.parseColor("#38BDF8"))
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 14f)
            setTypeface(typeface, Typeface.BOLD)
            isSingleLine = true
            setPadding(dp(8), dp(6), dp(4), dp(6))
            setOnClickListener { toggleTorch() }
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
        }
        topBar.addView(torchButton)
        root.addView(topBar)

        // Reticle View in the exact center of the screen & camera preview
        reticleBorder = GradientDrawable().apply {
            setColor(Color.parseColor("#0DFFFFFF"))
            cornerRadius = dp(12).toFloat()
            setStroke(dp(2), Color.parseColor("#38BDF8"))
        }

        reticleView = View(this).apply {
            background = reticleBorder
            layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                dp(96),
                Gravity.CENTER
            ).apply {
                leftMargin = dp(24)
                rightMargin = dp(24)
            }
        }
        root.addView(reticleView)

        // Status instruction text positioned cleanly below the centered reticle
        val statusLabel = TextView(this).apply {
            text = "Align VIN barcode or 17-character plate inside the frame"
            setTextColor(Color.WHITE)
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 13f)
            gravity = Gravity.CENTER
            layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT,
                Gravity.CENTER
            ).apply {
                leftMargin = dp(28)
                rightMargin = dp(28)
                topMargin = dp(76)
            }
        }
        root.addView(statusLabel)

        // Detected VIN pill button at bottom
        val candidateBg = GradientDrawable().apply {
            setColor(Color.parseColor("#10B981"))
            cornerRadius = dp(10).toFloat()
        }

        detectedCandidateButton = Button(this).apply {
            background = candidateBg
            setTextColor(Color.WHITE)
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 14f)
            typeface = Typeface.create(Typeface.MONOSPACE, Typeface.BOLD)
            isAllCaps = false
            setPadding(dp(20), dp(12), dp(20), dp(12))
            visibility = View.GONE
            setOnClickListener {
                lastCandidateVin?.let { completeWithVin(it) }
            }
            layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT,
                Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL
            ).apply {
                bottomMargin = dp(36)
            }
        }
        root.addView(detectedCandidateButton)

        setContentView(root)
    }

    private fun focusOnReticleCenter() {
        if (hasCompleted) return
        val cam = camera ?: return
        if (previewView.width <= 0 || previewView.height <= 0) return

        val centerX = reticleView.x + (reticleView.width / 2f)
        val centerY = reticleView.y + (reticleView.height / 2f)
        val point = previewView.meteringPointFactory.createPoint(centerX, centerY)
        val action = FocusMeteringAction.Builder(
            point,
            FocusMeteringAction.FLAG_AF or FocusMeteringAction.FLAG_AE
        )
            .disableAutoCancel()
            .build()
        cam.cameraControl.startFocusAndMetering(action)
    }

    private fun startCamera() {
        val cameraProviderFuture = ProcessCameraProvider.getInstance(this)
        cameraProviderFuture.addListener({
            val cameraProvider = cameraProviderFuture.get()

            val resolutionSelector = ResolutionSelector.Builder()
                .setAspectRatioStrategy(AspectRatioStrategy.RATIO_16_9_FALLBACK_AUTO_STRATEGY)
                .setResolutionStrategy(
                    ResolutionStrategy(
                        Size(1920, 1080),
                        ResolutionStrategy.FALLBACK_RULE_CLOSEST_HIGHER_THEN_LOWER
                    )
                )
                .build()

            val preview = Preview.Builder()
                .setResolutionSelector(resolutionSelector)
                .build()
                .also {
                    it.setSurfaceProvider(previewView.surfaceProvider)
                }

            val imageAnalysis = ImageAnalysis.Builder()
                .setResolutionSelector(resolutionSelector)
                .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                .build()
                .also {
                    it.setAnalyzer(cameraExecutor, ::analyzeFrame)
                }

            try {
                cameraProvider.unbindAll()
                val useCaseGroupBuilder = UseCaseGroup.Builder()
                    .addUseCase(preview)
                    .addUseCase(imageAnalysis)
                previewView.viewPort?.let { viewPort ->
                    useCaseGroupBuilder.setViewPort(viewPort)
                }

                camera = cameraProvider.bindToLifecycle(
                    this,
                    CameraSelector.DEFAULT_BACK_CAMERA,
                    useCaseGroupBuilder.build()
                )
                previewView.post { focusOnReticleCenter() }
            } catch (_: Exception) {
                finishCancelled()
            }
        }, ContextCompat.getMainExecutor(this))
    }

    @SuppressLint("UnsafeOptInUsageError")
    private fun analyzeFrame(imageProxy: ImageProxy) {
        if (hasCompleted) {
            imageProxy.close()
            return
        }

        val mediaImage = imageProxy.image
        if (mediaImage == null) {
            imageProxy.close()
            return
        }

        val rotationDegrees = imageProxy.imageInfo.rotationDegrees
        val crop = imageProxy.cropRect
        val imgW = imageProxy.width
        val imgH = imageProxy.height

        // Map the visible PreviewView center (where the centered reticle sits) to upright InputImage coordinates
        val uprightCenterY: Int
        val uprightVisibleHeight: Int
        when (rotationDegrees) {
            90 -> {
                uprightCenterY = crop.centerX()
                uprightVisibleHeight = crop.width()
            }
            270 -> {
                uprightCenterY = imgW - crop.centerX()
                uprightVisibleHeight = crop.width()
            }
            180 -> {
                uprightCenterY = imgH - crop.centerY()
                uprightVisibleHeight = crop.height()
            }
            else -> {
                uprightCenterY = crop.centerY()
                uprightVisibleHeight = crop.height()
            }
        }

        val inputImage = InputImage.fromMediaImage(mediaImage, rotationDegrees)

        recognizer.process(inputImage)
            .addOnSuccessListener { visionText ->
                if (!hasCompleted) {
                    val allLinesWithDistance = ArrayList<Pair<String, Int>>()
                    for (block in visionText.textBlocks) {
                        for (line in block.lines) {
                            val lineY = line.boundingBox?.centerY() ?: uprightCenterY
                            val distFromCenter = abs(lineY - uprightCenterY)
                            allLinesWithDistance.add(Pair(line.text, distFromCenter))
                        }
                    }

                    // Sort lines by proximity to the exact center reticle
                    allLinesWithDistance.sortBy { it.second }

                    val maxCenterZoneDistance = (uprightVisibleHeight * 0.22f).toInt()
                    val centerZoneLines = allLinesWithDistance
                        .filter { it.second <= maxCenterZoneDistance }
                        .map { it.first }

                    val allSortedLines = ArrayList(allLinesWithDistance.map { it.first })
                    latestRecognizedLines = allSortedLines

                    val detectedVin = extractIsoVin(centerZoneLines)
                    if (detectedVin != null) {
                        if (lastCandidateVin == detectedVin) {
                            candidateHitCount += 1
                        } else {
                            lastCandidateVin = detectedVin
                            candidateHitCount = 1
                        }

                        runOnUiThread {
                            detectedCandidateButton.text = "Use VIN: $detectedVin ✓"
                            detectedCandidateButton.visibility = View.VISIBLE
                        }

                        if (candidateHitCount >= 2) {
                            completeWithVin(detectedVin)
                        }
                    }
                }
            }
            .addOnCompleteListener {
                imageProxy.close()
            }
    }

    private fun toggleTorch() {
        val cam = camera ?: return
        if (cam.cameraInfo.hasFlashUnit()) {
            isTorchOn = !isTorchOn
            cam.cameraControl.enableTorch(isTorchOn)
        }
    }

    private fun completeWithVin(vin: String) {
        if (hasCompleted) return
        hasCompleted = true

        runOnUiThread {
            reticleView.performHapticFeedback(HapticFeedbackConstants.CONFIRM)
            reticleBorder.setStroke(dp(2), Color.parseColor("#10B981"))

            val data = Intent().apply {
                putExtra(EXTRA_VIN, vin)
                putStringArrayListExtra(EXTRA_LINES, latestRecognizedLines)
                putExtra(EXTRA_FULL_TEXT, latestRecognizedLines.joinToString("\n"))
            }
            setResult(Activity.RESULT_OK, data)
            finish()
        }
    }

    private fun finishCancelled() {
        if (hasCompleted) return
        hasCompleted = true
        setResult(Activity.RESULT_CANCELED)
        finish()
    }
}

