//
//  RVCameraPhotoOutputExtension.swift
//  RVCameraView
//
//  Created by Ravi Ranjan on 29/04/23.
//

import Foundation
import AVFoundation
extension RVCameraView: AVCapturePhotoCaptureDelegate {
    
    public func capture() {
        switch cameraOutputType {
        case .photo:
            let settings = AVCapturePhotoSettings()
            print("Capturing Photo")
            capturePhotoOutput.capturePhoto(with: settings, delegate: self)
        case .video:
            if isRecordingStarted { self.stopRecording() }
            else { self.startRecording() }

        case .none:
            let settings = AVCapturePhotoSettings()
            print("Capturing Photo")
            capturePhotoOutput.capturePhoto(with: settings, delegate: self)
        }
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else {
            print("Not able to get Image")
            return
        }
        
        guard let previewImage = UIImage(data: imageData) else {
            print("Unbale to capture Image")
            return
        }
        cameraImageOutputDelegate?.getCameraOutput(with: previewImage,videoURL: nil)
        
    }

}
