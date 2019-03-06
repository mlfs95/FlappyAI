//
//  PlayerGameController.swift
//  FlappyAI
//
//  Created by Matheus on 28/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation

class PlayerGameController: GameController, GameSceneDelegate {
    private var bird = Bird()
    
    override init(view: GameViewController) {
        super.init(view: view)
        gameScene.gameSceneDelegate = self
    }
    
    func touchBegan() {
        bird.jump()
    }
    
    override internal func startNewGame() {
        score = 0
        bird = Bird()
        gameScene.addChild(bird)
        super.startNewGame()
    }
    
    internal func didPassByPipe() {
        score += 1
        for pipes in listOfPipes {
            if let scoreNode = pipes.scoreNode {
                gameScene.removeChildren(in: [scoreNode])
                pipes.scoreNode = nil
                return
            }
        }
    }
    
    internal func birdDiedWith(index: Int) {
        pipeCreationTimer?.invalidate()
        gameScene.removeAllChildren()
        startNewGame()
    }
}
