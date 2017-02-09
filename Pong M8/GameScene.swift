//
//  GameScene.swift
//  Pong M8
//
//  Created by Christopher Onyango on 1/13/17.
//  Copyright © 2017 Christopher Onyango. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var score = [Int]()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    
    override func didMove(to view: SKView) {
        
        
        topLbl = self.childNode(withName: "topLabel")  as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()

        
           }
    
    func startGame(){
        score = [0,0]
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 2, dy: 2))
        
        
        
    }
    
    func addScore(playerWhoWon :SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -2, dy: 2))
        }
        else if playerWhoWon == enemy {
           score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -2, dy: 2))
        }
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0{
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.15))
                }
                if location.y  < 0{
                    
                    main.run(SKAction.moveTo(x: location.x, duration: 0.15))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.15))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0{
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.15))
                }
                if location.y  < 0{
                    
                   main.run(SKAction.moveTo(x: location.x, duration: 0.15))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.15))
            }
            
            
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.8))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.4))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.17))
            break
        case .player2:
            
            break
            
        }
        
        
        
        
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
        
        
    }
}
