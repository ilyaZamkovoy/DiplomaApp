//
//  VectorAndDistance.swift
//  DiplomaApp
//
//  Created by Zamkovoy Ilya on 22/05/2018.
//  Copyright © 2018 Zamkovoy Ilya. All rights reserved.
//

import Foundation
import ARKit

public extension SCNVector3 {
    
    var length:Float {
        get {
            return sqrtf(x*x + y*y + z*z)
        }
    }
    
    func distance(toVector: SCNVector3) -> Float {
        return (self - toVector).length
    }
    
    static func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
        return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    }
    
    static func -(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x - right.x, left.y - right.y, left.z - right.z)
    }
    
    static func center(_ vectors: [SCNVector3]) -> SCNVector3 {
        var x: Float = 0
        var y: Float = 0
        var z: Float = 0
        
        let size = Float(vectors.count)
        vectors.forEach {
            x += $0.x
            y += $0.y
            z += $0.z
        }
        return SCNVector3Make(x / size, y / size, z / size)
    }
}
