//
//  NodeAndText.swift
//  DiplomaApp
//
//  Created by Zamkovoy Ilya on 22/05/2018.
//  Copyright © 2018 Zamkovoy Ilya. All rights reserved.
//

import Foundation
import ARKit

public extension SCNNode {
    convenience init(withPosition position: SCNVector3m, param: String) {
        let depth : Float = 0.01
        
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        
        let param = SCNText(string: param, extrusionDepth: CGFloat(bubbleDepth))
        param.font = UIFont(name: "TimesNewRomanPSMT", size: 0.2)?.withTraits(traits: .traitBold)
        param.alignmentMode = kCAAlignmentCenter
        param.firstMaterial?.diffuse.contents = UIColor.black
        param.firstMaterial?.specular.contents = UIColor.black
        param.chamferRadius = CGFloat(bubbleDepth)
        
        let (minBound, maxBound) = param.boundingBox
        let paramNode = SCNNode(geometry: param)
        paramNode.pivot = SCNMatrix4MakeTranslation( (maxBound.x - minBound.x)/2, minBound.y, bubbleDepth/2)
        paramNode.scale = SCNVector3Make(0.2, 0.2, 0.2)
        paramNode.simdPosition = simd_float3.init(x: 0.05, y: 0.04, z: 0)
        
        let sphere = SCNSphere(radius: 0.004)
        sphere.firstMaterial?.diffuse.contents = UIColor.gray
        
        self.init()
        addChildNode(paramNode)
        constraints = [billboardConstraint]
        self.position = position
    }
    
    func move(_ position: SCNVector3)  {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.4
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        self.position = position
        opacity = 1
        SCNTransaction.commit()
    }
    
    func hide()  {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 2.0
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        opacity = 0
        SCNTransaction.commit()
    }
    
    func show()  {
        opacity = 0
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.4
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        opacity = 1
        SCNTransaction.commit()
    }
}

private extension UIFont {
    // Based on: https://stackoverflow.com/questions/4713236/how-do-i-set-bold-and-italic-on-uilabel-of-iphone-ipad
    func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
}
