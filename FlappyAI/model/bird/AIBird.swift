//
//  AIBird.swift
//  FlappyAI
//
//  Created by Matheus on 28/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class AIBird: Bird {
    let brain: Brain
    var index: Int
    var isDead = false
    var score = 0
    
    init(numberOfInputs: Int, index: Int) {
        brain = Brain(numberOfInputs: numberOfInputs)
        self.index = index
        super.init()
        self.name = "Bird\(index)"
        self.alpha = 0.3
    }
    
    init(weights: [Float], index: Int) {
        brain = Brain(weights: weights)
        self.index = index
        super.init()
        self.name = "Bird\(index)"
        self.alpha = 0.3
    }
    
    func thinksOfJumping(nextObstacle: Obstacle) {
        let upperPipePosition = Float(nextObstacle.upperPipe.frame.minY)
        let bottomPipePosition = Float(nextObstacle.bottomPipe.frame.maxY)
        let birdHeight = Float(self.frame.midY)
        if self.brain.think(inputs: [birdHeight, upperPipePosition, bottomPipePosition]) {
            self.jump()
        }
    }
    
    func copyBrain(bird: AIBird) {
        brain.copy(brain: bird.brain)
    }
    
    func mutateBirdWith(maxVariation: Float) {
        brain.mutateWith(maxVariation: maxVariation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
