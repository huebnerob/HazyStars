//
//  CG+Flutter.swift
//  HazyStars
//
//  Created by Robert Huebner on 4/17/16.
//  Copyright © 2016 huebnerob. All rights reserved.
//

import UIKit

extension CGFloat
{
    mutating func flutterBy(flutter: CGFloat)
    {
        self = (self - flutter) + ((2*flutter) * CGFloat(arc4random_uniform(10000))/CGFloat(10000))
    }
}

extension CGSize
{
    mutating func flutterBy(flutter: CGFloat)
    {
        self.width.flutterBy(flutter)
        self.height.flutterBy(flutter)
    }
}