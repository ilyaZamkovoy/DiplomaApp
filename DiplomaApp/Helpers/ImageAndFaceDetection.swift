//
//  ImageAndFaceDetection.swift
//  DiplomaApp
//
//  Created by Zamkovoy Ilya on 22/05/2018.
//  Copyright © 2018 Zamkovoy Ilya. All rights reserved.
//

import Foundation
import Vision
import ARKit

public extension CIImage {
    
    var rotate: CIImage {
        get {
            return self.oriented(UIDevice.current.orientation.cameraOrientation())
        }
    }
    
    func cropImage(toFace face: VNFaceObservation) -> CIImage {
        let percentage: CGFloat = 0.6
        
        let width = face.boundingBox.width * CGFloat(extent.size.width)
        let height = face.boundingBox.height * CGFloat(extent.size.height)
        let x = face.boundingBox.origin.x * CGFloat(extent.size.width)
        let y = face.boundingBox.origin.y * CGFloat(extent.size.height)
        let rect = CGRect(x: x, y: y, width: width, height: height)
        
        let increasedRect = rect.insetBy(dx: width * -percentage, dy: height * -percentage)
        return self.cropping(to: increasedRect)
    }
}

private extension UIDeviceOrientation {
    func cameraOrientation() -> CGImagePropertyOrientation {
        switch self {
        case .landscapeLeft: return .up
        case .landscapeRight: return .down
        case .portraitUpsideDown: return .left
        default: return .right
        }
    }
}

