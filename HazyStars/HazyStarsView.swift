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
        
        let starImage: UIImage
        
        static var Default: Configuration
        {
            return self.init(topColor: UIColor.blueColor(),
                             bottomColor: UIColor.greenColor(),
                             starImage: UIImage(named: "HazyStarsViewStarImage")!)
        }
    }
    
    let configuration = Configuration.Default
    
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
        let backgroundNode = SKShapeNode(rect: self.bounds)
        backgroundNode.fillColor = self.configuration.topColor
        
        let scene = SKScene(size: self.bounds.size)
        scene.addChild(backgroundNode)
        
        self.presentScene(scene)
    }
}
