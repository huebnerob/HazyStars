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
        let starSizeFlutter: CGFloat
        let starAlpha: CGFloat
        let starAlphaFlutter: CGFloat
        
        let starFadeInterval: NSTimeInterval
        let starFadeIntervalFlutter: NSTimeInterval
        
        let starAnimationInterval: NSTimeInterval
        let starAnimationIntervalFlutter: NSTimeInterval
        let starAnimationDistance: CGFloat
        let starAnimationDistanceFlutter: CGFloat
        
        static var Default: Configuration
        {
            return self.init(topColor: UIColor.blueColor(),
                             bottomColor: UIColor.greenColor(),
                             starImageName: "HazyStarsViewStarImage",
                             starCount: 150,
                             starSize: CGSizeMake(30.0, 30.0),
                             starSizeFlutter: 30.0,
                             starAlpha: 0.3,
                             starAlphaFlutter: 0.3,
                             starFadeInterval: 1.0,
                             starFadeIntervalFlutter: 0.5,
                             starAnimationInterval: 10.0,
                             starAnimationIntervalFlutter: 10.0,
                             starAnimationDistance: 0.0,
                             starAnimationDistanceFlutter: 40.0)
            
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
            self.addNewStarNode(scene)
        }
        
        // present scene
        
        self.presentScene(scene)
    }
    
    private func addNewStarNode(scene: SKScene)
    {
        let starNode = SKSpriteNode(imageNamed: self.configuration.starImageName)
        starNode.size = self.configuration.starSize
        starNode.size.flutterBy(self.configuration.starSizeFlutter)
        
        starNode.position = self.newRandomOrigin()
        scene.addChild(starNode)
        
        var x = self.configuration.starAnimationDistance
        x.flutterBy(self.configuration.starAnimationDistanceFlutter)
        var y = self.configuration.starAnimationDistance
        y.flutterBy(self.configuration.starAnimationDistanceFlutter)
        var t = self.configuration.starAnimationInterval
        t.flutterBy(self.configuration.starAnimationIntervalFlutter)
        let moveAction = SKAction.moveByX(x, y: y, duration: t)
        starNode.runAction(moveAction)
        
        
        var newAlpha = self.configuration.starAlpha
        newAlpha.flutterBy(self.configuration.starAlphaFlutter)
        starNode.alpha = 0.0
        
        var fadeDuration = self.configuration.starFadeInterval
        fadeDuration.flutterBy(self.configuration.starFadeIntervalFlutter)
        let fadeInAction = SKAction.fadeAlphaTo(newAlpha, duration: fadeDuration)
        starNode.runAction(fadeInAction)
        
        let waitAction = SKAction.waitForDuration(t-fadeDuration)
        starNode.runAction(waitAction) { [weak self] in
            
            let fadeOutAction = SKAction.fadeAlphaTo(0.0, duration: fadeDuration)
            starNode.runAction(fadeOutAction, completion: {
                
                let removeAction = SKAction.removeFromParent()
                starNode.runAction(removeAction)
            })
            
            self?.addNewStarNode(scene)
        }
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
