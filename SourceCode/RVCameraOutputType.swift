//
//  RVCameraOutputType.swift
//  RVCameraView
//
//  Created by Ravi Ranjan on 29/04/23.
//

import Foundation
protocol CameraOutputDeviceDescriptionProtocol {
    var cameraDeviceDescription: String {get}
}
public enum RVCameraOutputType : CameraOutputDeviceDescriptionProtocol{
    case photo
    case video
    
    var cameraDeviceDescription: String {
        switch self {
        case .photo:
            return "Phot Camera"
        case .video:
            return "Video Camera"
        }
    }
}
