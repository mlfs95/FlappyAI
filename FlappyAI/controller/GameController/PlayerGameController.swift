//
//  PlayerGameController.swift
//  FlappyAI
//
//  Created by Matheus on 28/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerGameController: GameController, GameSceneDelegate {
    private var bird = Bird()
    
    override init(view: GameViewController, gameScene: GameScene, textureAltas: SKTextureAtlas) {
        super.init(view: view, gameScene: gameScene, textureAltas: textureAltas)
        gameScene.gameSceneDelegate = self
    }
    
    func touchBegan() {
        bird.jump()
    }
    
    override internal func startNewGame() {
        bird = Bird()
        gameScene.addChild(bird)
        super.startNewGame()
        score = 0
    }
    
    internal func birdDiedWith(index: Int) {
        gameScene.removeAllActions()
        gameScene.removeAllChildren()
        startNewGame()
    }
}
