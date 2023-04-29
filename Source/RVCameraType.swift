//
//  RVCameraType.swift
//  RVCameraView
//
//  Created by Ravi Ranjan on 29/04/23.
//

import Foundation

protocol CameraDeviceDescriptionProtocol {
    var cameraDeviceDescription: String {get}
}
public enum RVCameraType : CameraDeviceDescriptionProtocol{
    case front
    case back
    
    var cameraDeviceDescription: String {
        switch self {
        case .front:
            return "Front Camera"
        case .back:
            return "Back Camera"
        }
    }
}
