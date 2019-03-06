//
//  Pipes.swift
//  FlappyAI
//
//  Created by Matheus on 19/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class Pipes {
    private let SPACE_BETWEEN_PIPES = 80
    private let MINIMUM_PIPE_HEIGHT = 150
    static let CATEGORY_BIT_MASK: UInt32 = 0x1
    let startingXPosition: Int
    var upperPipe: UpperPipe
    var bottomPipe: BottomPipe
    var scoreNode: ScoreNode?
    var xPosition: Int {
        get {
            return Int(upperPipe.frame.maxX)
        }
    }
    
    init(screenSize: CGSize) {
        let randomHeightPosition = Int.random(in: MINIMUM_PIPE_HEIGHT...Int(screenSize.height)-MINIMUM_PIPE_HEIGHT-SPACE_BETWEEN_PIPES)
        startingXPosition = Int(screenSize.width + 150)
        bottomPipe = BottomPipe(
            xPosition: startingXPosition,
            yPosition: randomHeightPosition - Pipe.PIPE_HEIGHT/2)
        upperPipe = UpperPipe(xPosition: startingXPosition, yPosition: bottomPipe.yPosition + Pipe.PIPE_HEIGHT + SPACE_BETWEEN_PIPES)
        scoreNode = ScoreNode(xPosition: startingXPosition, yPosition: randomHeightPosition + SPACE_BETWEEN_PIPES/2, height: SPACE_BETWEEN_PIPES)
    }
}
