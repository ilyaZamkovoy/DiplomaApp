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
    convenience init(withText text : String, position: SCNVector3m, user: User) {
        let bubbleDepth : Float = 0.01 // the 'depth' of 3D text
        
        // TEXT BILLBOARD CONSTRAINT
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        
        // BUBBLE-TEXT
        let bubble = SCNText(string: user.name, extrusionDepth: CGFloat(bubbleDepth))
        bubble.font = UIFont(name: "Futura", size: 0.18)?.withTraits(traits: .traitBold)
        bubble.alignmentMode = kCAAlignmentCenter
        bubble.firstMaterial?.diffuse.contents = UIColor.red
        bubble.firstMaterial?.specular.contents = UIColor.white
        bubble.chamferRadius = CGFloat(bubbleDepth)
        
        let bubble2 = SCNText(string: user.facultyID, extrusionDepth: CGFloat(bubbleDepth))
        bubble2.font = UIFont(name: "Futura", size: 0.18)?.withTraits(traits: .traitBold)
        bubble2.alignmentMode = kCAAlignmentCenter
        bubble2.firstMaterial?.diffuse.contents = UIColor.black
        bubble2.firstMaterial?.specular.contents = UIColor.white
        bubble2.chamferRadius = CGFloat(bubbleDepth)
        
        let bubble3 = SCNText(string: user.group, extrusionDepth: CGFloat(bubbleDepth))
        bubble3.font = UIFont(name: "Futura", size: 0.18)?.withTraits(traits: .traitBold)
        bubble3.alignmentMode = kCAAlignmentCenter
        bubble3.firstMaterial?.diffuse.contents = UIColor.black
        bubble3.firstMaterial?.specular.contents = UIColor.white
        bubble3.firstMaterial?.isDoubleSided = true
        bubble3.chamferRadius = CGFloat(bubbleDepth)
        
        // BUBBLE NODE
        let (minBound, maxBound) = bubble.boundingBox
        let bubbleNode = SCNNode(geometry: bubble)
        let bubbleNode1 = SCNNode(geometry: bubble2)
        let bubbleNode2 = SCNNode(geometry: bubble3)
        // Centre Node - to Centre-Bottom point
        bubbleNode.pivot = SCNMatrix4MakeTranslation( (maxBound.x - minBound.x)/2, minBound.y, bubbleDepth/2)
        bubbleNode1.pivot = SCNMatrix4MakeTranslation( (maxBound.x - minBound.x)/2, minBound.y, bubbleDepth/2)
        bubbleNode2.pivot = SCNMatrix4MakeTranslation( (maxBound.x - minBound.x)/2, minBound.y, bubbleDepth/2)
        // Reduce default text size
        bubbleNode.scale = SCNVector3Make(0.2, 0.2, 0.2)
        bubbleNode.simdPosition = simd_float3.init(x: 0.05, y: 0.04, z: 0)
        bubbleNode1.scale = SCNVector3Make(0.2, 0.2, 0.2)
        bubbleNode1.simdPosition = simd_float3.init(x: 0.05, y: 0.08, z: 0)
        bubbleNode2.scale = SCNVector3Make(0.2, 0.2, 0.2)
        bubbleNode2.simdPosition = simd_float3.init(x: 0.05, y: 0.12, z: 0)
        
        // CENTRE POINT NODE
        let sphere = SCNSphere(radius: 0.004)
        sphere.firstMaterial?.diffuse.contents = UIColor.gray
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.opacity = 0.6
        
        self.init()
        addChildNode(bubbleNode)
        addChildNode(bubbleNode1)
        addChildNode(bubbleNode2)
        addChildNode(sphereNode)
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
