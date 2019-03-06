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
    internal var listOfPipes = [Pipes]()
    internal var gameViewController: GameViewController
    internal var scoreLabel = BaseSKLabel()
    internal let gameScene = GameScene()
    internal var pipeCreationTimer: Timer?
    internal var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    init(view: GameViewController) {
        self.gameViewController = view
        let skView = gameViewController.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(gameScene)
        scoreLabel.position = CGPoint(x: view.view.frame.midX, y: view.view.frame.maxY - 50)
        startNewGame()
    }
    
    internal func startNewGame() {
        createBorders()
        listOfPipes.removeAll()
        gameScene.addChild(scoreLabel)
        startPipeCreation()
    }

    private func startPipeCreation() {
        pipeCreationTimer = Timer.scheduledTimer(timeInterval: 2.3, target: self, selector: #selector(createNewPipesNodes), userInfo: nil, repeats: true)
        pipeCreationTimer!.fire()
    }
    
    private func createBorders() {
        gameScene.addChild(Wall())
        gameScene.addChild(Ground())
        gameScene.addChild(Ceiling(screenSize: gameViewController.view.frame.size))
    }
    
    @objc private func createNewPipesNodes() {
        let newPipes = Pipes(screenSize: self.gameViewController.view.frame.size)
        listOfPipes.append(newPipes)
        gameScene.addChild(newPipes.upperPipe)
        gameScene.addChild(newPipes.bottomPipe)
        gameScene.addChild(newPipes.scoreNode!)
    }
    
    // This function is actually from the GameSceneDelegate that every class that inherits from GameController should conforms
    internal func pipesShouldBeRemoved() {
        var nodesThatShouldBeRemoved: [SKSpriteNode] =  [(listOfPipes.first?.bottomPipe)!, (listOfPipes.first?.upperPipe)!]
        if let scoreNode = listOfPipes.first?.scoreNode { nodesThatShouldBeRemoved.append(scoreNode) }
        gameScene.removeChildren(in: nodesThatShouldBeRemoved)
        listOfPipes.remove(at: 0)
    }
}
