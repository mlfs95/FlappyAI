//
//  VersusGameController.swift
//  FlappyAI
//
//  Created by Matheus Soares on 20/12/21.
//  Copyright © 2021 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class VersusGameController: PlayerGameController {
    private var aiBird = AIBird(numberOfInputs: 4, index: 1)
    private var thinkingTimer: Timer?
    
    override internal func startNewGame() {
        aiBird = AIBird(weights: [-0.80146164, 0.27981612, 0.53299767, -0.25000766], index: 1)
        gameScene.addChild(aiBird)
        super.startNewGame()
        startBirdThinkingTimer()
    }
    
    private func startBirdThinkingTimer() {
        thinkingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.makeBirdsThink()
        })
        thinkingTimer!.fire()
    }
    
    private func makeBirdsThink() {
        if let closestObstacle = getClosestObstacle() {
            aiBird.thinksOfJumping(nextObstacle: closestObstacle)
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
    
    override internal func birdDiedWith(index: Int) {
        if index == -1 {
            gameScene.removeAllActions()
            gameScene.removeAllChildren()
            startNewGame()
        } else {
            gameScene.removeChildren(in: [aiBird])
        }
    }
}

