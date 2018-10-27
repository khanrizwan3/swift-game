//
//  MLWall.swift
//  New Ninja
//
//  Created by Mac Programmer on 14/06/2015.
//  Copyright (c) 2015 Scopun Tech. All rights reserved.
//

import Foundation
import SpriteKit

class MLWall: SKSpriteNode {
    
    let WALL_WIDTH: CGFloat = 30.0
    let WALL_HEIGHT: CGFloat = 50.0
    let WALL_COLOUR = UIColor.blackColor()
    
    init(){
        
        let size = CGSizeMake(WALL_WIDTH, WALL_HEIGHT)
        super.init(texture: nil, color: WALL_COLOUR , size: size)
        
        loadPhysicsSizeWithBody(size)
        startMoving()
    }
    
    func loadPhysicsSizeWithBody(size: CGSize){
        
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        //physicsBody?.categoryBitMask = heroCategory
        physicsBody?.contactTestBitMask = wallCategory
        physicsBody?.affectedByGravity = false
        
    }
    
    func startMoving(){
        
        let moveLeft = SKAction.moveByX(-KMDefaultXMovePerSecond, y: 0, duration: 1.0)
        runAction(SKAction.repeatActionForever(moveLeft))
        
    }
    
    func stopMoving(){
        removeAllActions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}