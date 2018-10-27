//
//  MLMovingGround.swift
//  New Ninja
//
//  Created by Mac Programmer on 10/06/2015.
//  Copyright (c) 2015 Scopun Tech. All rights reserved.
//

import Foundation
import SpriteKit

class MLMovingGround: SKSpriteNode {
    
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor(red: 88.0/255.0, green: 148.0/255.0, blue: 87.8/255.0, alpha: 1.0)
    let COLOR_TWO = UIColor(red: 120.0/255.0, green: 180.0/255, blue: 118.0/255.0, alpha: 1.0)
    
    init(size:CGSize){
        super.init(texture: nil , color: UIColor.clearColor() , size: CGSize(width: size.width*2, height: size.height))
        anchorPoint = CGPointMake(0, 0.5)
        
        for var i = 0 ; i < NUMBER_OF_SEGMENTS ; i++ {
            
            var segmentColour = UIColor()
            
            if i%2 == 0 {
                segmentColour = COLOR_ONE
            } else {
                segmentColour = COLOR_TWO
            }
            
            let segment = SKSpriteNode(color: segmentColour, size: CGSizeMake(self.size.width / CGFloat(NUMBER_OF_SEGMENTS), self.size.height ))
            segment.anchorPoint = CGPointMake(0, 0.5)
            segment.position = CGPointMake(CGFloat(i)*segment.size.width, 0)
            addChild(segment)
            
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(){
        
        let adjustedDuration = NSTimeInterval(frame.size.width/KMDefaultXMovePerSecond)
        let moveleft = SKAction.moveByX(-frame.size.width/2, y: 0, duration: adjustedDuration/2)
        let resetposition = SKAction.moveToX(0, duration: 0)
        
        let moveSequence = SKAction.sequence([moveleft,resetposition])
        
        runAction(SKAction.repeatActionForever(moveSequence))
    }
    
    func stopGround(){
        removeAllActions()
    }
    
}
