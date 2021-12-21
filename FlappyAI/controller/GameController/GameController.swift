//
//  GameController.swift
//  FlappyAI
//
//  Created by Matheus on 19/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class GameController {
    private let MINIMUM_OBSTACLE_GAP_HEIGHT = 150
    private let X_DISTANCE_BETWEEN_OBSTACLES = 232
    private let upperPipeTexture: SKTexture
    private let bottomPipeTexture: SKTexture
    private let groundTexture: SKTexture
    private let backgroundTexture: SKTexture
    internal var listOfObstacles = [Obstacle]()
    internal var gameViewController: GameViewController
    internal var scoreLabel = BaseSKLabel()
    internal var highScoreLabel = BaseSKLabel()
    internal let gameScene: GameScene
    internal var obstacleCreationAction: SKAction?
    internal var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    internal var highScore = -1 {
        didSet {
            highScoreLabel.text = "Pontuação máxima: \(highScore)"
        }
    }
    
    init(view: GameViewController, gameScene: GameScene, textureAltas: SKTextureAtlas) {
        self.gameViewController = view
        self.upperPipeTexture = textureAltas.textureNamed("upper-pipe")
        self.bottomPipeTexture = textureAltas.textureNamed("bottom-pipe")
        self.groundTexture = textureAltas.textureNamed("ground")
        self.backgroundTexture = textureAltas.textureNamed("background")
        self.gameScene = gameScene
        highScoreLabel.fontColor = .black
        highScoreLabel.fontName = "Copperplate"
        highScoreLabel.fontSize = 20
        createObstacleSpawnAction()
        scoreLabel.fontColor = .black
        scoreLabel.fontName = "Copperplate"
        startNewGame()
    }
    
    private func createObstacleSpawnAction() {
        let spawn = SKAction.run({ () in self.createNewObstacle()})
        let delay = SKAction.wait(forDuration: 2.3)
        let spawningSequence = SKAction.sequence([spawn, delay])
        self.obstacleCreationAction = SKAction.repeatForever(spawningSequence)
    }
    
    internal func addSceneChilds() {
        gameScene.addChild(Background(texture: self.backgroundTexture, screenFrame: gameScene.frame))
        gameScene.addChild(Wall())
        gameScene.addChild(Ground(groundTexture: groundTexture, screenWidth: gameScene.frame.width))
        gameScene.addChild(Ceiling(screenSize: gameViewController.view.frame.size))
        scoreLabel.position = CGPoint(x: gameScene.view!.frame.midX, y: gameScene.view!.frame.maxY - 200)
        gameScene.addChild(scoreLabel)
        highScoreLabel.position = CGPoint(x: gameScene.view!.frame.maxX - highScoreLabel.width()/2 - 20 , y: gameScene.view!.frame.maxY - 50)
        gameScene.addChild(highScoreLabel)
    }
    
    internal func startNewGame() {
        addSceneChilds()
        listOfObstacles.removeAll()
        gameScene.run(obstacleCreationAction!)
        if highScore < score {
            highScore = score
        }
    }
    
    // TODO - calcular distancia possivel!!
    private func findRandomObstacleGapHeight() -> Int {
        return Int.random(in: MINIMUM_OBSTACLE_GAP_HEIGHT...Int(self.gameViewController.view.frame.size.height)-MINIMUM_OBSTACLE_GAP_HEIGHT)
    }
    
    private func createNewObstacle() {
        let newObstacle = Obstacle(screenSize: self.gameViewController.view.frame.size, bottomPipeTexture: bottomPipeTexture, upperPipeTexture: upperPipeTexture)
        listOfObstacles.append(newObstacle)
        gameScene.addChild(newObstacle.upperPipe)
        gameScene.addChild(newObstacle.bottomPipe)
        gameScene.addChild(newObstacle.scoreNode!)
    }
    
    internal func didPassByPipe() {
        score += 1
        for obstacle in listOfObstacles {
            if let scoreNode = obstacle.scoreNode {
                gameScene.removeChildren(in: [scoreNode])
                obstacle.scoreNode = nil
                return
            }
        }
    }
    
    // This function is actually from the GameSceneDelegate that every class that inherits from GameController should conforms
    internal func pipesShouldBeRemoved() {
        var nodesThatShouldBeRemoved: [SKSpriteNode] =  [(listOfObstacles.first?.bottomPipe)!, (listOfObstacles.first?.upperPipe)!]
        if let scoreNode = listOfObstacles.first?.scoreNode { nodesThatShouldBeRemoved.append(scoreNode) }
        gameScene.removeChildren(in: nodesThatShouldBeRemoved)
    }
}
