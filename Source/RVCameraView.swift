//
//  RVCameraView.swift
//  RVCameraView
//
//  Created by Ravi Ranjan on 29/04/23.
//
import Foundation
import UIKit
import AVFoundation

final public class RVCameraView: UIView, RVCameraProtocol {
    
    let captureSession = AVCaptureSession()
    let rvCameraViewQueue = DispatchQueue(label: "com.rvcameraView.queue",attributes: .concurrent,autoreleaseFrequency: .inherit,target: .global())
    let capturePhotoOutput = AVCapturePhotoOutput()
    let movieOutput = AVCaptureMovieFileOutput()
    public var cameraImageOutputDelegate: RVCameraImageOutputProtocol?
    public var cameraType: RVCameraType? {
        didSet {
            self.addCameraInput()
        }
    }
    public var cameraOutputType: RVCameraOutputType?  {
        didSet {
            self.configureOutPut()
        }
    }
    
    var isRecordingStarted: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func cameraPhotoOutput() {
        if captureSession.canAddOutput(capturePhotoOutput) {
            captureSession.addOutput(capturePhotoOutput)
        }
    }
    
    private func cameraVideoOutput() {
        if captureSession.canAddOutput(movieOutput) {
            captureSession.addOutput(movieOutput)
        }
    }
    
    public func initiliseRVCameraView() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        self.addCameraInput()
        self.configureOutPut()
        self.addRVCameraViewPreviewLayer()
    }
    
    
    public func configureOutPut() {
        switch cameraOutputType {
        case .photo:
            self.cameraPhotoOutput()
        case .video:
            self.cameraVideoOutput()
        case .none:
            self.cameraPhotoOutput()
        }
    }
    
    private func addCameraInput() {
        
        if let inputToRemove = captureSession.inputs.first(where: { $0 is AVCaptureDeviceInput }) as? AVCaptureDeviceInput {
            captureSession.removeInput(inputToRemove)
        }
        
        guard let captureInputDevice : AVCaptureDevice = getCamera() else {
            print("Unable to create capture device type ", cameraType?.cameraDeviceDescription as Any)
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureInputDevice)
            captureSession.addInput(input)
        } catch let error {
            print("Error creating AVCaptureDeviceInput: \(error.localizedDescription)")
        }
    }
    
    private func getCamera() -> AVCaptureDevice? {
        switch cameraType {
        case .front:
            return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        case .back:
            return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            
        case .none:
            return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        }
    }
    
    
    private func addRVCameraViewPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = self.bounds
        self.layer.addSublayer(previewLayer)
        self.startRVCameraSession()
        
    }
    
    private func startRVCameraSession() {
        rvCameraViewQueue.async {
            self.captureSession.startRunning()
        }
    }
    
}
