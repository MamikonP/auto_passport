import AVFoundation
import Flutter
import UIKit
import Vision

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private let channelName = "com.auto_passport/ocr"
  private var methodChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let messenger = engineBridge.applicationRegistrar.messenger()
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: messenger)
    self.methodChannel = channel

    channel.setMethodCallHandler { [weak self] call, result in
      self?.handleMethodCall(call: call, result: result)
    }
  }

  private func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "checkCameraPermission":
      result(currentCameraPermissionStatus())

    case "requestCameraPermission":
      requestCameraPermission(result: result)

    case "openAppSettings":
      openAppSettings(result: result)

    case "recognizeText":
      guard let args = call.arguments as? [String: Any],
            let imagePath = args["imagePath"] as? String else {
        result(FlutterError(code: "INVALID_ARGS", message: "imagePath is required", details: nil))
        return
      }
      recognizeText(fromPath: imagePath, result: result)

    case "scanVinWithCamera":
      presentLiveVinScanner(result: result)

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func currentCameraPermissionStatus() -> String {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
      return "granted"
    case .notDetermined:
      return "notDetermined"
    case .restricted:
      return "restricted"
    case .denied:
      return "permanentlyDenied"
    @unknown default:
      return "denied"
    }
  }

  private func requestCameraPermission(result: @escaping FlutterResult) {
    let status = AVCaptureDevice.authorizationStatus(for: .video)
    switch status {
    case .authorized:
      result("granted")
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { granted in
        DispatchQueue.main.async {
          result(granted ? "granted" : "denied")
        }
      }
    case .restricted:
      result("restricted")
    case .denied:
      result("permanentlyDenied")
    @unknown default:
      result("denied")
    }
  }

  private func openAppSettings(result: @escaping FlutterResult) {
    guard let url = URL(string: UIApplication.openSettingsURLString),
          UIApplication.shared.canOpenURL(url) else {
      result(false)
      return
    }
    UIApplication.shared.open(url, options: [:]) { success in
      result(success)
    }
  }

  private func recognizeText(fromPath imagePath: String, result: @escaping FlutterResult) {
    DispatchQueue.global(qos: .userInitiated).async {
      guard let image = UIImage(contentsOfFile: imagePath),
            let cgImage = image.cgImage else {
        DispatchQueue.main.async {
          result(FlutterError(code: "IMAGE_LOAD_ERROR", message: "Failed to load image at \(imagePath)", details: nil))
        }
        return
      }

      let request = VNRecognizeTextRequest { request, error in
        if let error = error {
          DispatchQueue.main.async {
            result(FlutterError(code: "OCR_ERROR", message: error.localizedDescription, details: nil))
          }
          return
        }

        let observations = request.results as? [VNRecognizedTextObservation] ?? []
        var lines: [String] = []

        for observation in observations {
          let candidates = observation.topCandidates(3)
          for (index, candidate) in candidates.enumerated() {
            if index == 0 || candidate.string.count >= 10 {
              lines.append(candidate.string)
            }
          }
        }

        let fullText = lines.joined(separator: "\n")
        DispatchQueue.main.async {
          result([
            "fullText": fullText,
            "lines": lines
          ])
        }
      }

      request.recognitionLevel = .accurate
      request.usesLanguageCorrection = false
      request.minimumTextHeight = 0.015

      let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
      do {
        try handler.perform([request])
      } catch {
        DispatchQueue.main.async {
          result(FlutterError(code: "OCR_HANDLER_ERROR", message: error.localizedDescription, details: nil))
        }
      }
    }
  }

  private func presentLiveVinScanner(result: @escaping FlutterResult) {
    guard AVCaptureDevice.default(for: .video) != nil else {
      result(FlutterError(code: "NO_CAMERA", message: "Camera hardware is not available on this device", details: nil))
      return
    }

    guard let rootVC = topViewController() else {
      result(FlutterError(code: "NO_VIEW_CONTROLLER", message: "Unable to find root view controller", details: nil))
      return
    }

    let scannerVC = NativeVinScannerViewController { scannedVin, recognizedLines in
      if let vin = scannedVin {
        result([
          "vin": vin,
          "fullText": recognizedLines.joined(separator: "\n"),
          "lines": recognizedLines
        ])
      } else {
        result(nil)
      }
    }
    scannerVC.modalPresentationStyle = .fullScreen
    rootVC.present(scannerVC, animated: true)
  }

  private func topViewController(base: UIViewController? = nil) -> UIViewController? {
    let root: UIViewController?
    if let base = base {
      root = base
    } else {
      let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
      let keyWindow = scenes.flatMap { $0.windows }.first { $0.isKeyWindow }
      root = keyWindow?.rootViewController
    }

    if let nav = root as? UINavigationController {
      return topViewController(base: nav.visibleViewController)
    }
    if let tab = root as? UITabBarController, let selected = tab.selectedViewController {
      return topViewController(base: selected)
    }
    if let presented = root?.presentedViewController {
      return topViewController(base: presented)
    }
    return root
  }
}

// MARK: - Native Live Camera VIN Scanner (Vision + AVFoundation)

final class NativeVinScannerViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
  private let onComplete: (String?, [String]) -> Void
  private let captureSession = AVCaptureSession()
  private let sessionQueue = DispatchQueue(label: "com.auto_passport.vin_scanner_queue")
  private var previewLayer: AVCaptureVideoPreviewLayer?

  private var isProcessingFrame = false
  private var hasCompleted = false
  private var lastCandidateVin: String?
  private var candidateHitCount = 0
  private var latestRecognizedLines: [String] = []

  private let statusLabel = UILabel()
  private let detectedCandidateButton = UIButton(type: .system)
  private let reticleView = UIView()

  init(onComplete: @escaping (String?, [String]) -> Void) {
    self.onComplete = onComplete
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    setupCamera()
    setupOverlayUI()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    previewLayer?.frame = view.bounds
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    sessionQueue.async { [weak self] in
      if let self = self, !self.captureSession.isRunning {
        self.captureSession.startRunning()
      }
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    sessionQueue.async { [weak self] in
      if let self = self, self.captureSession.isRunning {
        self.captureSession.stopRunning()
      }
    }
  }

  private func setupCamera() {
    captureSession.sessionPreset = .hd1920x1080
    guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
          let input = try? AVCaptureDeviceInput(device: device) else {
      return
    }

    if device.isFocusModeSupported(.continuousAutoFocus) {
      try? device.lockForConfiguration()
      device.focusMode = .continuousAutoFocus
      device.unlockForConfiguration()
    }

    if captureSession.canAddInput(input) {
      captureSession.addInput(input)
    }

    let output = AVCaptureVideoDataOutput()
    output.alwaysDiscardsLateVideoFrames = true
    output.setSampleBufferDelegate(self, queue: sessionQueue)

    if captureSession.canAddOutput(output) {
      captureSession.addOutput(output)
    }

    let preview = AVCaptureVideoPreviewLayer(session: captureSession)
    preview.videoGravity = .resizeAspectFill
    preview.frame = view.bounds
    view.layer.addSublayer(preview)
    self.previewLayer = preview
  }

  private func setupOverlayUI() {
    let topBar = UIView()
    topBar.translatesAutoresizingMaskIntoConstraints = false
    topBar.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    view.addSubview(topBar)

    let cancelButton = UIButton(type: .system)
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.setTitle("✕ Cancel", for: .normal)
    cancelButton.setTitleColor(.white, for: .normal)
    cancelButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
    cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    topBar.addSubview(cancelButton)

    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.text = "Scan 17-Digit VIN"
    titleLabel.textColor = .white
    titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
    topBar.addSubview(titleLabel)

    let torchButton = UIButton(type: .system)
    torchButton.translatesAutoresizingMaskIntoConstraints = false
    torchButton.setTitle("⚡ Light", for: .normal)
    torchButton.setTitleColor(UIColor(red: 0.22, green: 0.74, blue: 0.97, alpha: 1.0), for: .normal)
    torchButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    torchButton.addTarget(self, action: #selector(didTapTorch), for: .touchUpInside)
    topBar.addSubview(torchButton)

    reticleView.translatesAutoresizingMaskIntoConstraints = false
    reticleView.layer.borderColor = UIColor(red: 0.22, green: 0.74, blue: 0.97, alpha: 1.0).cgColor
    reticleView.layer.borderWidth = 2.0
    reticleView.layer.cornerRadius = 12
    reticleView.backgroundColor = UIColor.white.withAlphaComponent(0.05)
    view.addSubview(reticleView)

    statusLabel.translatesAutoresizingMaskIntoConstraints = false
    statusLabel.text = "Align VIN barcode or 17-character plate inside the frame"
    statusLabel.textColor = .white
    statusLabel.textAlignment = .center
    statusLabel.numberOfLines = 2
    statusLabel.font = .systemFont(ofSize: 13, weight: .medium)
    view.addSubview(statusLabel)

    detectedCandidateButton.translatesAutoresizingMaskIntoConstraints = false
    detectedCandidateButton.backgroundColor = UIColor(red: 0.06, green: 0.73, blue: 0.51, alpha: 1.0)
    detectedCandidateButton.setTitleColor(.white, for: .normal)
    detectedCandidateButton.titleLabel?.font = .monospacedSystemFont(ofSize: 14, weight: .bold)
    detectedCandidateButton.layer.cornerRadius = 10
    detectedCandidateButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
    detectedCandidateButton.isHidden = true
    detectedCandidateButton.addTarget(self, action: #selector(didTapUseCandidate), for: .touchUpInside)
    view.addSubview(detectedCandidateButton)

    NSLayoutConstraint.activate([
      topBar.topAnchor.constraint(equalTo: view.topAnchor),
      topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 52),

      cancelButton.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 16),
      cancelButton.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -12),

      titleLabel.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),

      torchButton.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -16),
      torchButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),

      reticleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      reticleView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
      reticleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      reticleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      reticleView.heightAnchor.constraint(equalToConstant: 96),

      statusLabel.topAnchor.constraint(equalTo: reticleView.bottomAnchor, constant: 18),
      statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
      statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),

      detectedCandidateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
      detectedCandidateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    ])
  }

  @objc private func didTapCancel() {
    guard !hasCompleted else { return }
    hasCompleted = true
    dismiss(animated: true) { [weak self] in
      self?.onComplete(nil, [])
    }
  }

  @objc private func didTapTorch() {
    guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
    try? device.lockForConfiguration()
    device.torchMode = (device.torchMode == .on) ? .off : .on
    device.unlockForConfiguration()
  }

  @objc private func didTapUseCandidate() {
    guard !hasCompleted, let candidate = lastCandidateVin else { return }
    completeWithVin(candidate)
  }

  private func completeWithVin(_ vin: String) {
    guard !hasCompleted else { return }
    hasCompleted = true
    DispatchQueue.main.async {
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.success)
      self.reticleView.layer.borderColor = UIColor.systemGreen.cgColor
      self.dismiss(animated: true) { [weak self] in
        guard let self = self else { return }
        self.onComplete(vin, self.latestRecognizedLines)
      }
    }
  }

  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    guard !isProcessingFrame && !hasCompleted else { return }
    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
    isProcessingFrame = true

    let request = VNRecognizeTextRequest { [weak self] req, _ in
      guard let self = self else { return }
      defer { self.isProcessingFrame = false }

      let observations = req.results as? [VNRecognizedTextObservation] ?? []
      var lines: [String] = []
      for obs in observations {
        for candidate in obs.topCandidates(2) {
          lines.append(candidate.string)
        }
      }
      self.latestRecognizedLines = lines

      if let detectedVin = Self.extractIsoVin(from: lines) {
        if self.lastCandidateVin == detectedVin {
          self.candidateHitCount += 1
        } else {
          self.lastCandidateVin = detectedVin
          self.candidateHitCount = 1
        }

        DispatchQueue.main.async {
          self.detectedCandidateButton.setTitle("Use VIN: \(detectedVin) ✓", for: .normal)
          self.detectedCandidateButton.isHidden = false
        }

        if self.candidateHitCount >= 2 {
          self.completeWithVin(detectedVin)
        }
      }
    }

    request.recognitionLevel = .accurate
    request.usesLanguageCorrection = false
    request.minimumTextHeight = 0.02

    let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:])
    try? handler.perform([request])
  }

  private static func extractIsoVin(from lines: [String]) -> String? {
    for rawLine in lines {
      let cleaned = rawLine
        .uppercased()
        .replacingOccurrences(of: "VIN", with: " ")
        .replacingOccurrences(of: "[^A-Z0-9]", with: " ", options: .regularExpression)

      let tokens = cleaned.split(separator: " ").map(String.init)
      for token in tokens where token.count == 17 {
        let normalized = token
          .replacingOccurrences(of: "O", with: "0")
          .replacingOccurrences(of: "I", with: "1")
          .replacingOccurrences(of: "Q", with: "0")

        let hasLetter = normalized.range(of: "[A-HJ-NPR-Z]", options: .regularExpression) != nil
        let hasDigit = normalized.range(of: "[0-9]", options: .regularExpression) != nil
        let validPattern = normalized.range(of: "^[A-HJ-NPR-Z0-9]{17}$", options: .regularExpression) != nil
        if validPattern && hasLetter && hasDigit {
          return normalized
        }
      }
    }
    return nil
  }
}
