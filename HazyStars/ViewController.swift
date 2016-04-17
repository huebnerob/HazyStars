//
//  ViewController.swift
//  HazyStars
//
//  Created by Robert Huebner on 4/17/16.
//  Copyright © 2016 huebnerob. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let hazyStarsView = HazyStarsView(frame: self.view.bounds)
        self.view.addSubview(hazyStarsView)
    }
}

