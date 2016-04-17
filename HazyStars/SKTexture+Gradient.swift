//
//  SKTexture+Gradient.swift
//  HazyStars
//
//  Created by Robert Huebner on 4/17/16.
//  Copyright © 2016 huebnerob. All rights reserved.
//

import Foundation
import SpriteKit
import CoreImage

// adapted from https://craiggrummitt.wordpress.com/2015/03/24/skshapenode-gradient/

enum GradientDirection
{
    case Up
    case Left
    case UpLeft
    case UpRight
}

extension SKTexture
{
    convenience init(gradientWithSize size: CGSize, color1: UIColor, color2: UIColor, direction:GradientDirection = .Up)
    {
        let coreImageContext = CIContext(options: nil)
        let gradientFilter = CIFilter(name: "CILinearGradient")!
        gradientFilter.setDefaults()
        
        var startVector: CIVector
        var endVector: CIVector
        
        switch direction
        {
        case .Up:
            startVector = CIVector(x: size.width/2, y: 0)
            endVector = CIVector(x: size.width/2, y: size.height)
        case .Left:
            startVector = CIVector(x: size.width, y: size.height/2)
            endVector = CIVector(x: 0, y: size.height/2)
        case .UpLeft:
            startVector = CIVector(x: size.width, y: 0)
            endVector = CIVector(x: 0, y: size.height)
        case .UpRight:
            startVector = CIVector(x: 0, y: 0)
            endVector = CIVector(x: size.width, y: size.height)
            
        }
        
        gradientFilter.setValue(startVector, forKey: "inputPoint0")
        gradientFilter.setValue(endVector, forKey: "inputPoint1")
        gradientFilter.setValue(CIColor(color: color1), forKey: "inputColor0")
        gradientFilter.setValue(CIColor(color: color2), forKey: "inputColor1")
        
        let cgimg = coreImageContext.createCGImage(gradientFilter.outputImage!, fromRect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        self.init(CGImage: cgimg)
    }
}