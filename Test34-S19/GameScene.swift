//
//  GameScene.swift
//  Test34-S19
//
//  Created by MacStudent on 2019-06-19.
//  Copyright © 2019 rabbit. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var nextLevelButton:SKLabelNode!
    
 
    let mario = SKSpriteNode(imageNamed: "mario")

    
    var timeOfLastUpdate:TimeInterval = 0
    var time: TimeInterval = 0
    
    
    func spawnmario() {
        let mario = SKSpriteNode(imageNamed:"mario")
        
        // put sand at a random (x,y) position
        let x = self.size.width
        let y = self.size.height - 100
        mario.position.x = x
        mario.position.y = y
        
        // add physics
        mario.physicsBody = SKPhysicsBody(circleOfRadius: mario.size.width / 2)
        self.mario.physicsBody?.affectedByGravity = true
        
        addChild(mario)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // make new sand every 10ms
        self.time = currentTime - timeOfLastUpdate
        if (self.time >= 0.9) {
            timeOfLastUpdate = currentTime
            self.spawnmario()
        }
       
        
        
    }
    
    
    override func didMove(to view: SKView) {
        print("This is level 1")
 self.nextLevelButton = self.childNode(withName: "nextLevelButton") as! SKLabelNode
       
        
    }
    func makePlatform(xPosition:CGFloat, yPosition:CGFloat) {
        
        // 1. create an orange sprite
        let platform = SKSpriteNode(imageNamed: "platform")
        
        // 2. set initial position of orange to be same
        // as where mouse is clicked
        platform.position.x = xPosition;
        platform.position.y = yPosition;
        
        addChild(platform)
    }
    
    var mouseStartingPosition:CGPoint = CGPoint(x:0, y:0)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if (touch == nil) {
            return
        }
        
        let location = touch!.location(in:self)
        let node = self.atPoint(location)
        
        
        
        
        // MARK: Switch Levels
        if (node.name == "nextLevelButton") {
            let scene = SKScene(fileNamed:"Level2")
            if (scene == nil) {
                print("Error loading level")
                return
            }
            else {
                scene!.scaleMode = .aspectFill
                view?.presentScene(scene!)
            }
        }
        
        // 1. detect where the person clicked
        let touches = touches.first!
        let mousePosition = touches.location(in:self)
        
        let spriteTouched = self.atPoint(mousePosition)
        if (spriteTouched.name == "platform") {
//            self.makePlatform(
//                xPosition:mousePosition.x,
//                yPosition:mousePosition.y)
            self.mouseStartingPosition = mousePosition
            
            
            print("Starting position: \(mouseStartingPosition.x), \(mouseStartingPosition.y)")
            print("Ending position: \(mousePosition.x), \(mousePosition.y)")
        }
        
    }
}
