//
//  AIGameController.swift
//  FlappyAI
//
//  Created by Matheus on 28/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class AIGameController: GameController, GameSceneDelegate, GenerationControllerDelegate {
    private var generationLabel: BaseSKLabel
    private var generationController = GenerationController()
    private var scoreTimer: Timer!
    private var thinkingTimer: Timer!
    private var hiddenScore: Int
    
    override init(view: GameViewController, gameScene: GameScene, textureAltas: SKTextureAtlas) {
        generationLabel = BaseSKLabel()
        generationLabel.text = "Generation - 1"
        generationLabel.fontColor = .black
        generationLabel.fontName = "Copperplate"
        generationLabel.fontSize = 15
        hiddenScore = 0
        super.init(view: view, gameScene: gameScene, textureAltas: textureAltas)
        gameScene.gameSceneDelegate = self
        generationController.delegate = self
        startNewGeneration()
    }
    
    private func startNewGeneration() {
        generationLabel.text = "Generation - \(generationController.currentGeneration)"
        gameScene.addChild(generationLabel)
        generationLabel.position = CGPoint(x: gameScene.view!.frame.maxX - generationLabel.width()/2 - 20 , y: gameScene.view!.frame.maxY - 100)
        score = 0
        hiddenScore = 0
        var birdCount = 0
        generationController.birds.forEach { bird in
            gameScene.addChild(bird)
            birdCount += 1
        }
        startScoreTimer()
        startBirdThinkingTimer()
    }
    
    func startScoreTimer() {
        scoreTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.hiddenScore += 1
        })
        scoreTimer.fire()
    }
    
    private func startBirdThinkingTimer() {
        thinkingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.makeBirdsThink()
        })
        thinkingTimer.fire()
    }
    
    private func makeBirdsThink() {
        if let closestObstacle = getClosestObstacle() {
            generationController.makeBirdsThink(nextObstacle: closestObstacle)
        }
    }
    
    private func getClosestObstacle() -> Obstacle? {
        var closest = listOfObstacles.first
        var closestDistance = Int.max
        for pipe in listOfObstacles {
            if pipe.xPosition > Bird.BIRD_X_POSITION - Bird.BIRD_WIDTH/2 {
                let currentPipeDistance = pipe.xPosition - Bird.BIRD_X_POSITION
                if closestDistance > currentPipeDistance {
                    closest = pipe
                    closestDistance = currentPipeDistance
                }
            }
        }
        return closest
    }
    
    internal func birdDiedWith(index: Int) {
        if let bird = generationController.birdDiedWithIndexAndScore(index: index, score: hiddenScore) {
            gameScene.removeChildren(in: [bird])
        }
    }
    
    internal func resetGeneration() {
        scoreTimer.invalidate()
        gameScene.removeAllActions()
        gameScene.removeAllChildren()
        startNewGame()
        startNewGeneration()
    }
}
