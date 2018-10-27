//
//  MLCloud.swift
//  New Ninja
//
//  Created by Mac Programmer on 13/06/2015.
//  Copyright (c) 2015 Scopun Tech. All rights reserved.
//

import Foundation
import SpriteKit


class MLCloud: SKShapeNode {
    
    init(size: CGSize){
        
        super.init()
        
        let path = CGPathCreateWithEllipseInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height), nil)
        self.path = path
        fillColor = UIColor.whiteColor()
        startMoving()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func startMoving(){
        
        let leftmove = SKAction.moveByX(-10, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(leftmove))
        
    }
    
    
    
}
