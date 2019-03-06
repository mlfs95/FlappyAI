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
    private var highScoreLabel: BaseSKLabel
    private var highScore = 0 {
        didSet {
            highScoreLabel.text = "Best: \(highScore)"
        }
    }
    private var generationController = GenerationController()
    private var scoreTimer: Timer!
    private var thinkingTimer: Timer!
    
    override init(view: GameViewController) {
        generationLabel = BaseSKLabel()
        generationLabel.text = "Generation - 1"
        generationLabel.fontSize = 15
        highScoreLabel = BaseSKLabel()
        highScoreLabel.text = "Best: 0"
        highScoreLabel.fontSize = 15
        super.init(view: view)
        gameScene.gameSceneDelegate = self
        generationController.delegate = self
        startNewGeneration()
    }
    
    private func startNewGeneration() {
        generationLabel.text = "Generation - \(generationController.currentGeneration)"
        gameScene.addChild(generationLabel)
        generationLabel.position = CGPoint(x: generationLabel.width()/2 + 20, y: gameViewController.view.frame.maxY - 50)
        gameScene.addChild(highScoreLabel)
        highScoreLabel.position = CGPoint(x: gameViewController.view.frame.maxX - highScoreLabel.width()/2 - 20 , y: gameViewController.view.frame.maxY - 50)

        if highScore < score {
            highScore = score
        }
        score = 0
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
            self.score += 1
        })
        scoreTimer.fire()
    }
    
    private func startBirdThinkingTimer() {
        thinkingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.startBirdsThoughts()
        })
        thinkingTimer.fire()
    }
    
    private func startBirdsThoughts() {
        let closestPipe = getClosestPipes()
        let upperPipePosition = Float(closestPipe.upperPipe.frame.minY)
        let bottomPipePosition = Float(closestPipe.bottomPipe.frame.maxY)
        let distanceToClosestPipe = Float(closestPipe.xPosition - Bird.BIRD_X_POSITION - Bird.BIRD_WIDTH/2)
        generationController.makeBirdsThink(closestUpperPipePosition: upperPipePosition, closestBottomPipePosition: bottomPipePosition, distanceToClosestPipe: distanceToClosestPipe)
    }
    
    private func getClosestPipes() -> Pipes {
        var closest = listOfPipes.first
        var closestDistance = Int.max
        for pipe in listOfPipes {
            if pipe.xPosition > Bird.BIRD_X_POSITION - Bird.BIRD_WIDTH/2 {
                let currentPipeDistance = pipe.xPosition - Bird.BIRD_X_POSITION
                if closestDistance > currentPipeDistance {
                    closest = pipe
                    closestDistance = currentPipeDistance
                }
            }
        }
        return closest!
    }
    
    internal func birdDiedWith(index: Int) {
        if let bird = generationController.birdDiedWithIndexAndScore(index: index, score: score) {
            gameScene.removeChildren(in: [bird])
        }
    }
    
    internal func resetGeneration() {
        scoreTimer.invalidate()
        pipeCreationTimer?.invalidate()
        gameScene.removeAllChildren()
        startNewGame()
        startNewGeneration()
    }
}
