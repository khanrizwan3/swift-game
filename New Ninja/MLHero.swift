//
//  MLHero.swift
//  New Ninja
//
//  Created by Mac Programmer on 11/06/2015.
//  Copyright (c) 2015 Scopun Tech. All rights reserved.
//

import Foundation
import SpriteKit

class MLHero: SKSpriteNode {
    
    var body: SKSpriteNode!
    var arm: SKSpriteNode!
    var leftfoot: SKSpriteNode!
    var rightfoot: SKSpriteNode!
    var isupsidedown = false
    
    init(){
        let size = CGSizeMake(32, 44)
        super.init(texture:nil ,color: UIColor.clearColor() , size: size)
        
        loadAppearance()
        loadPhysicsSizeWithBody(size)
        
    }
    
    
    func loadPhysicsSizeWithBody(size: CGSize){
        
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = heroCategory
        physicsBody?.contactTestBitMask = wallCategory
        physicsBody?.affectedByGravity = false
        
    }
    
    func loadAppearance(){
        
        // creating body of object
        body = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(32, 40))
        body.position = CGPointMake(0, 2)
        addChild(body)
        
        
        let skincolor = UIColor(red: 207.0/255.0, green: 193.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        let face = SKSpriteNode(color: skincolor, size: CGSizeMake(self.frame.size.width, 12))
        face.position = CGPointMake(0, 6)
        body.addChild(face)
        
        
        let eyecolor = UIColor.whiteColor()
        let lefteye = SKSpriteNode(color: eyecolor, size: CGSizeMake(6, 6))
        let righteye = lefteye.copy() as! SKSpriteNode
        let pupil = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(3, 3))
        
        pupil.position = CGPointMake(2, 0)
        lefteye.addChild(pupil)
        righteye.addChild(pupil.copy() as! SKSpriteNode)
        
        lefteye.position = CGPointMake(-4, 0)
        face.addChild(lefteye)
        
        righteye.position = CGPointMake(14, 0)
        face.addChild(righteye)
        
        let eyebrowse = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(11, 1))
        eyebrowse.position = CGPointMake(-1, lefteye.size.height/2)
        lefteye.addChild(eyebrowse)
        righteye.addChild(eyebrowse.copy() as! SKSpriteNode)
        
        let armcolor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1.0)
        arm = SKSpriteNode(color: armcolor, size: CGSizeMake(8, 4))
        arm.anchorPoint = CGPointMake(0.5, 0.9)
        arm.position = CGPointMake(-10, -7)
        body.addChild(arm)
        
        let hand = SKSpriteNode(color: skincolor, size: CGSizeMake(arm.size.width  , 5))
        
        hand.position = CGPointMake(0, -arm.size.width*0.9 + hand.size.height/2)
        arm.addChild(hand)
        
        
        leftfoot = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(9, 4))
        leftfoot.position = CGPointMake(-6, -size.height/2 + leftfoot.size.height/2)
        addChild(leftfoot)
        
        
        rightfoot = leftfoot.copy() as! SKSpriteNode
        rightfoot.position.x = 6
        addChild(rightfoot)
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startRunning(){
        
        let rotateBack = SKAction.rotateByAngle(-CGFloat(M_PI)/2.0, duration: 1.0)
        arm.runAction(rotateBack)
        
        performRunCycle()
    }
    
    
    func performRunCycle(){
        
        let up = SKAction.moveByX(0, y: -2, duration: 0.05)
        let down = SKAction.moveByX(0, y: 2, duration: 0.05)
        
        leftfoot.runAction(up, completion: { () -> Void in
            self.leftfoot.runAction(down)
            self.rightfoot.runAction(up, completion: { () -> Void in
                self.rightfoot.runAction(down, completion: { () -> Void in
                    self.performRunCycle()
                })
            })
        })
        
        
    }
    
    func flip(){
        
        isupsidedown = !isupsidedown
        
        var scale: CGFloat!
        var valueOfGround: CGFloat!
        if isupsidedown {
            scale = -1.0
        } else {
            scale = 1.0
        }
        
        /*
        print("Hero Flip Scale value. \(scale)")
        print("translate Varibale \(scale * (size.height + KMLmovingGround ))")
        print("size height of ground \(size.height)")
        */
        
        valueOfGround = scale * ( size.height + KMLmovingGround )
        if(scale == 1.0 ){
            valueOfGround = 64.0
        }
        
        let translate = SKAction.moveByX(0, y: valueOfGround, duration: 0.1 )
        
        let flip = SKAction.scaleYTo(scale, duration: 0.1)
        runAction(translate)
        runAction(flip)
        
        let popSound = SKAction.playSoundFileNamed("flipSound.wav", waitForCompletion: false)
        runAction(popSound)
        
    }
    
    
    func breathe(){
        
        let breatheOut = SKAction.moveByX(0, y: -2, duration: 0.5)
        let breatheIn = SKAction.moveByX(0, y: 2, duration: 0.5)
        let breathe = SKAction.sequence([breatheOut,breatheIn])
        body.runAction(SKAction.repeatActionForever(breathe))
        
    }
    
    func stop(){
        body.removeAllActions()
    }
    
}

