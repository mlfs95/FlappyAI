//
//  Generation.swift
//  FlappyAI
//
//  Created by Matheus on 28/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation

class GenerationController {
    private let AMOUNT_OF_BIRDS = 75
    private let MUTATION_VARIATION: Float = 0.1
    private var birdsAlive: Int
    var birds = [AIBird]()
    var currentGeneration: Int
    var delegate: GenerationControllerDelegate!
    
    init() {
        birdsAlive = AMOUNT_OF_BIRDS
        currentGeneration = 1
        for i in 0..<AMOUNT_OF_BIRDS {
            birds.append(AIBird(numberOfInputs: 4, index: i))
        }
    }
    
    private func newGeneration() {
        birdsAlive = AMOUNT_OF_BIRDS
        currentGeneration += 1
        let bestBird = findBestBird()
        birds.removeAll()
        createNewMutatedBirdsBasedOnBestBird(bestBird: bestBird)
    }
    
    private func findBestBird() -> AIBird {
        var bestBird = birds.first!
        birds.forEach { bird in
            if bird.score > bestBird.score {
                bestBird = bird
            }
        }
        return bestBird
    }
    
    private func createNewMutatedBirdsBasedOnBestBird(bestBird: AIBird) {
        for i in 0..<AMOUNT_OF_BIRDS {
            birds.append(AIBird(numberOfInputs: 4, index: i))
            birds[i].copyBrain(bird: bestBird)
            if i != 0 {
                birds[i].mutateBirdWith(maxVariation: MUTATION_VARIATION)
            }
        }
    }
    
    func makeBirdsThink(nextObstacle: Obstacle) {
        birds.forEach { bird in
            bird.thinksOfJumping(nextObstacle: nextObstacle)
        }
    }
    
    func birdDiedWithIndexAndScore(index: Int, score: Int) -> AIBird? {
        if !birds[index].isDead {
            birds[index].isDead = true
            birds[index].score = score
            birdsAlive -= 1
            if birdsAlive == 0 {
                generationDied()
                return nil
            }
            return birds[index]
        }
        return nil
    }
    
    private func generationDied() {
        newGeneration()
        self.delegate.resetGeneration()
    }
}

protocol GenerationControllerDelegate {
    func resetGeneration()
}

extension GenerationControllerDelegate {
    func resetGeneration() { print("resetGeneration() not implemented") }
}
