//
//  GameScene.swift
//  New Ninja
//
//  Created by Mac Programmer on 10/06/2015.
//  Copyright (c) 2015 Scopun Tech. All rights reserved.
//

import SpriteKit

@available(iOS 9.0, *)
class GameScene: SKScene , SKPhysicsContactDelegate {
    
    var movingground: MLMovingGround!
    var hero: MLHero!
    var cloudGenerator: MLCloudGenerator!
    var Cloud: MLCloud!
    var isStarted = false
    var wallGenerator: MLWallGenereator!
    var wall: MLWall!
    var isGameOver = false
    var gameOverLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var scorePrev: Int = 0
    var popSound: SKAudioNode!
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor(red: 150.0/255.0, green: 201.0/255.0 , blue: 244.0/255.0 , alpha: 1.0)
        
        cloudGenerator?.removeFromParent()
        addingClouds();
        
        // adding moving ground
        movingground = MLMovingGround(size: CGSizeMake(view.frame.width, KMLmovingGround))
        movingground.position = CGPointMake(0, view.frame.size.width/2)
        addChild(movingground)
        
        // adding hero
        hero = MLHero()
        hero.position = CGPointMake(70, movingground.position.y + movingground.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        
        hero.breathe();
        
        wallGenerator = MLWallGenereator(color: UIColor.clearColor(), size: frame.size)
        wallGenerator.position = CGPointMake(300, view.frame.size.width/2)
        addChild(wallGenerator)
        
        // add physics world
        physicsWorld.contactDelegate = self
        
    }
    
    func addScore(){
        
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.fontColor = UIColor.blackColor()
        scoreLabel.fontName = "Helvetica"
        scoreLabel.position.x = view!.center.x
        scoreLabel.position.y = view!.center.y + 330
        scoreLabel.fontSize = 22
        addChild(scoreLabel)
        scorePrev = score
        
    }
    
    func backgroundSound(){
        popSound = SKAudioNode(fileNamed: "background.wav")
        addChild(popSound)
    }
    
    func addingClouds(){
        // adding cloud
        cloudGenerator = MLCloudGenerator(color: UIColor.clearColor(), size: view!.frame.size)
        cloudGenerator.position = view!.center
        addChild(cloudGenerator)
        cloudGenerator.populate(7)
                
        cloudGenerator.startGeneratingWithSpawnTime(5)
        
    }
    
    func start(){
        
        isStarted = true
        isGameOver = false
        //addingClouds()
        hero.stop()
        hero.startRunning()
        movingground.start()
        //hero.flip()
        
        wallGenerator.startGeneratingwallsEvery(2)
        backgroundSound()
    }
    
    func GameOver(){
        
        isGameOver = true
        hero.physicsBody = nil
        wallGenerator.stopWalls()
        //wall.stopMoving()
        //wallGenerator.stopWalls()
        movingground.stopGround()
        //hero.stop()
        //cloudGenerator.stopGenerating()
        
        //creating game over label.
        ///scoreLabel.text =
        gameOverLabel = SKLabelNode(text: "Game Over! Tap here to restart.")
        gameOverLabel.fontColor = UIColor.blackColor()
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.position.x = view!.center.x
        gameOverLabel.position.y = view!.center.y + 40
        gameOverLabel.fontSize = 22
        addChild(gameOverLabel)
        
        hero?.removeFromParent()
        popSound?.removeFromParent()
        
        
    }
    
    func restart(){
        
        // stop generating cloud
        cloudGenerator.stopGenerating()
        
        
        //create and configure the scene
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        
        // present the scene
        view!.presentScene(scene)
        
        isGameOver = false
        //hero.stop()
        gameOverLabel?.removeFromParent()
        hero.startRunning()
        movingground.start()
        
        wallGenerator.startGeneratingwallsEvery(2)
        //gameOverLabel?.removeFromParent()
        score = 0
        backgroundSound()
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if isGameOver {
            restart()
            isStarted = true
            //isGameOver = false
        }
        else if !isStarted {
            start()
        } else if isStarted {
           hero.flip()
        }
        
        
        scoreLabel?.removeFromParent()
        addScore()
        
        
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //Mark skphysics contact delegate.
    
    func didBeginContact(contact: SKPhysicsContact) {
        GameOver()
        //score = 0
        print("didBeginContact called")
    }
    
}
