//
//  HazyStarsView.swift
//  HazyStars
//
//  Created by Robert Huebner on 4/17/16.
//  Copyright © 2016 huebnerob. All rights reserved.
//

import UIKit
import SpriteKit

class HazyStarsView: SKView
{
    struct Configuration
    {
        let topColor: UIColor
        let bottomColor: UIColor
        
        let starImageName: String
        let starCount: Int
        let starSize: CGSize
        let starAlpha: CGFloat
        let starSizeFlutter: CGFloat
        let starAlphaFlutter: CGFloat
        
        static var Default: Configuration
        {
            return self.init(topColor: UIColor.blueColor(),
                             bottomColor: UIColor.greenColor(),
                             starImageName: "HazyStarsViewStarImage",
                             starCount: 30,
                             starSize: CGSizeMake(75.0, 75.0),
                             starAlpha: 0.7,
                             starSizeFlutter: 50.0,
                             starAlphaFlutter: 0.2)
            
        }
    }
    
    private let configuration = Configuration.Default
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    // MARK: - 
    
    private func setup()
    {
        // setup background
        
        let backgroundNode = SKShapeNode(rect: self.bounds)
        backgroundNode.fillColor = UIColor.whiteColor() // this is required to actually display a texture, despite the docs saying it's ignored :X
        backgroundNode.fillTexture = SKTexture(gradientWithSize: self.bounds.size, color1: self.configuration.topColor, color2: self.configuration.bottomColor)
        
        let scene = SKScene(size: self.bounds.size)
        scene.addChild(backgroundNode)
        
        // setup stars
        
        for _ in 0 ..< self.configuration.starCount
        {
            let starNode = SKSpriteNode(imageNamed: self.configuration.starImageName)
            starNode.size = self.configuration.starSize
            starNode.size.flutterBy(self.configuration.starSizeFlutter)
            starNode.alpha = self.configuration.starAlpha
            starNode.alpha.flutterBy(self.configuration.starAlphaFlutter)
            
            starNode.position = self.newRandomOrigin()
            scene.addChild(starNode)
        }
        
        // present scene
        
        self.presentScene(scene)
    }
    
    // MARK: - Frame getter
    
    private func newRandomOrigin() -> CGPoint
    {
        let halfWidth = self.bounds.size.width / 2.0
        let halfHeight = self.bounds.size.height / 2.0
        
        var x = halfWidth
        x.flutterBy(halfWidth)
        var y = halfHeight
        y.flutterBy(halfHeight)
        
        return CGPoint(x: x, y: y)
    }
}
