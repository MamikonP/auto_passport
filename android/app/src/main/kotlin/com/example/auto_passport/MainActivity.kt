package com.example.auto_passport

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.Settings
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private val channelName = "com.auto_passport/ocr"
    private val cameraPermissionRequestCode = 1001
    private val vinScannerRequestCode = 1002

    private var pendingPermissionResult: MethodChannel.Result? = null
    private var pendingScannerResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                handleMethodCall(call, result)
            }
    }

    private fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "checkCameraPermission" -> {
                val granted = ContextCompat.checkSelfPermission(
                    this,
                    Manifest.permission.CAMERA
                ) == PackageManager.PERMISSION_GRANTED
                result.success(if (granted) "granted" else "notDetermined")
            }

            "requestCameraPermission" -> {
                val granted = ContextCompat.checkSelfPermission(
                    this,
                    Manifest.permission.CAMERA
                ) == PackageManager.PERMISSION_GRANTED
                if (granted) {
                    result.success("granted")
                } else {
                    pendingPermissionResult = result
                    ActivityCompat.requestPermissions(
                        this,
                        arrayOf(Manifest.permission.CAMERA),
                        cameraPermissionRequestCode
                    )
                }
            }

            "openAppSettings" -> {
                try {
                    val intent = Intent(
                        Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                        Uri.fromParts("package", packageName, null)
                    )
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    startActivity(intent)
                    result.success(true)
                } catch (e: Exception) {
                    result.success(false)
                }
            }

            "recognizeText" -> {
                val imagePath = call.argument<String>("imagePath")
                if (imagePath.isNullOrBlank()) {
                    result.error("INVALID_ARGS", "imagePath is required", null)
                    return
                }
                recognizeTextFromPath(imagePath, result)
            }

            "scanVinWithCamera" -> {
                if (!packageManager.hasSystemFeature(PackageManager.FEATURE_CAMERA_ANY)) {
                    result.error("NO_CAMERA", "Camera hardware is not available on this device", null)
                    return
                }
                pendingScannerResult = result
                val intent = Intent(this, NativeVinScannerActivity::class.java)
                startActivityForResult(intent, vinScannerRequestCode)
            }

            else -> result.notImplemented()
        }
    }

    private fun recognizeTextFromPath(imagePath: String, result: MethodChannel.Result) {
        try {
            val file = File(imagePath)
            if (!file.exists()) {
                result.error("FILE_NOT_FOUND", "Image file does not exist: $imagePath", null)
                return
            }

            val inputImage = InputImage.fromFilePath(this, Uri.fromFile(file))
            val recognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)

            recognizer.process(inputImage)
                .addOnSuccessListener { visionText ->
                    val lines = mutableListOf<String>()
                    for (block in visionText.textBlocks) {
                        for (line in block.lines) {
                            lines.add(line.text)
                        }
                    }
                    result.success(
                        mapOf(
                            "fullText" to visionText.text,
                            "lines" to lines
                        )
                    )
                }
                .addOnFailureListener { e ->
                    result.error("OCR_ERROR", e.localizedMessage ?: "Failed to recognize text", null)
                }
        } catch (e: Exception) {
            result.error("OCR_EXCEPTION", e.localizedMessage ?: "Unexpected OCR error", null)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == vinScannerRequestCode) {
            val callback = pendingScannerResult
            pendingScannerResult = null
            if (callback != null) {
                if (resultCode == Activity.RESULT_OK && data != null) {
                    val vin = data.getStringExtra(NativeVinScannerActivity.EXTRA_VIN)
                    val lines = data.getStringArrayListExtra(NativeVinScannerActivity.EXTRA_LINES) ?: arrayListOf()
                    val fullText = data.getStringExtra(NativeVinScannerActivity.EXTRA_FULL_TEXT) ?: ""
                    callback.success(
                        mapOf(
                            "vin" to vin,
                            "fullText" to fullText,
                            "lines" to lines
                        )
                    )
                } else {
                    callback.success(null)
                }
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == cameraPermissionRequestCode) {
            val callback = pendingPermissionResult
            pendingPermissionResult = null
            if (callback != null) {
                val granted = grantResults.isNotEmpty() &&
                    grantResults[0] == PackageManager.PERMISSION_GRANTED
                if (granted) {
                    callback.success("granted")
                } else {
                    val showRationale = ActivityCompat.shouldShowRequestPermissionRationale(
                        this,
                        Manifest.permission.CAMERA
                    )
                    callback.success(if (showRationale) "denied" else "permanentlyDenied")
                }
            }
        }
    }
}
