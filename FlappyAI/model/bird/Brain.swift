//
//  Perceptron.swift
//  FlappyAI
//
//  Created by Matheus on 27/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation

class Brain {
    private let numberOfInputs: Int
    public private(set) var weights = [Float]()
    
    init(numberOfInputs: Int) {
        self.numberOfInputs = numberOfInputs
        for _ in 0..<numberOfInputs {
            weights.append(Float.random(in: -1...1))
        }
    }
    
    func think(inputs: [Float]) -> Bool {
        var sum: Float = 0
        for i in 0..<numberOfInputs {
            sum += Float(inputs[i] * weights[i])
        }
        if sum >= 0 { return true }
        return false
    }
    
    func copy(brain: Brain) {
        self.weights = brain.weights
    }
    
    func mutateWith(maxVariation: Float) {
        var variations = [Float]()
        for _ in 0..<numberOfInputs {
            variations.append(Float.random(in: maxVariation.negative()...maxVariation))
        }
        for i in 0..<numberOfInputs {
            weights[i] += variations[i]
        }
    }
}

extension Float {
    func negative() -> Float {
        return self * -1
    }
}
