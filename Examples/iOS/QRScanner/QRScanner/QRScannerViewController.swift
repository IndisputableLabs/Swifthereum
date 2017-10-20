//
//  QRScannerViewController.swift
//  Swifthereum_Example
//
//  Created by Ronald Mannak on 10/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import AVFoundation

protocol QRCodeProtocol: class {
    func qrScanner(_ scanner: QRScannerViewController, didScan address: Address)
    func qrScannerDidCancel(_ scanner: QRScannerViewController)
}

class QRScannerViewController: UIViewController {

    var device: AVCaptureDevice? = AVCaptureDevice.default(for: .video)
    var output = AVCaptureMetadataOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?
    var captureSession = AVCaptureSession()
    var lastScannedCode: String?

    weak var delegate: QRCodeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCamera()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession.isRunning == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession.isRunning == true) {
            captureSession.stopRunning();
        }
    }

    @IBAction func cancel(_ sender: Any) {
        delegate?.qrScannerDidCancel(self)
    }
    
    private func setupCamera() {
        
        guard let device = device, let input = try? AVCaptureDeviceInput(device: device), self.captureSession.canAddInput(input) else {
            delegate?.qrScannerDidCancel(self)
            return
        }
        
        self.captureSession.addInput(input)
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        guard let videoPreviewLayer = self.previewLayer else {
            delegate?.qrScannerDidCancel(self)
            return
        }
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = self.view.bounds
        view.layer.addSublayer(videoPreviewLayer)
        
        let metadataOutput = AVCaptureMetadataOutput()
        guard self.captureSession.canAddOutput(metadataOutput) else {
            delegate?.qrScannerDidCancel(self)
            return
        }
        self.captureSession.addOutput(metadataOutput)
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    }
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        for object in metadataObjects {
            guard let readableObject = object as? AVMetadataMachineReadableCodeObject, let qrCode = readableObject.stringValue, let address = try? Address(qrCode: qrCode), qrCode != lastScannedCode else { continue }
            lastScannedCode = qrCode
            delegate?.qrScanner(self, didScan: address)
            return
        }
    }
}
