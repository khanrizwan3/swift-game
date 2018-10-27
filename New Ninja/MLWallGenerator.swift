//
//  MLWallGenerator.swift
//  New Ninja
//
//  Created by Mac Programmer on 14/06/2015.
//  Copyright (c) 2015 Scopun Tech. All rights reserved.
//

import Foundation
import SpriteKit

class MLWallGenereator: SKSpriteNode {
    
    var generationTinmer: NSTimer?
    var walls = [MLWall]()
    
    
    func startGeneratingwallsEvery(seconds: NSTimeInterval){
        
        generationTinmer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
        
        
    
    }
    
    func stopGeneratingWalls(){
        generationTinmer?.invalidate()
    }
    
    
    func generateWall(){
        
        var scale: CGFloat
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
         scale = 1.0
        } else {
            scale = -1.0
        }
        
        
        let wall = MLWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * ( KMLmovingGround/2 + wall.size.height/2 )
        addChild(wall)
        
        score++
        
        
    }
    
    func stopWalls(){
        stopGeneratingWalls()
        for wall in walls{
            wall.stopMoving()
        }
        
    }
    
    
}