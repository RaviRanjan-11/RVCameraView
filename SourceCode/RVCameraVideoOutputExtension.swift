//
//  RVCameraVideoOutputExtension.swift
//  RVCameraView
//
//  Created by Ravi Ranjan on 29/04/23.
//

import Foundation
import AVFoundation

extension RVCameraView: AVCaptureFileOutputRecordingDelegate {

    public func startRecording() {

        let outputURL = getOutputURL()
        movieOutput.startRecording(to: outputURL, recordingDelegate: self)
        self.isRecordingStarted = true
        print("Video Recoriding is started")
    }

    // Add this method to stop recording video
    public func stopRecording() {
        movieOutput.stopRecording()
        self.isRecordingStarted = false
        print("Video Recording is Stopped")
    }

    public func fileOutput(_ output: AVCaptureFileOutput,
                    didFinishRecordingTo outputFileURL: URL,
                    from connections: [AVCaptureConnection],
                    error: Error?) {

        if let error = error {
            print("Error recording movie: \(error.localizedDescription)")
        } else {
            // Handle the recorded video file at the outputFileURL
            print("Recorded video file: \(outputFileURL.absoluteString)")
            cameraImageOutputDelegate?.getCameraOutput(with: nil, videoURL: outputFileURL)
        }
    }

    // This method returns a unique output URL for the recorded video file
    private func getOutputURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd-HHmmss"
        let fileName = "video-\(dateFormatter.string(from: Date())).mov"
        let outputURL = documentsDirectory.appendingPathComponent(fileName)
        return outputURL
    }
}
