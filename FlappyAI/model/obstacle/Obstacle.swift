//
//  Obstacle.swift
//  FlappyAI
//
//  Created by Matheus on 19/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacle {
    private let GAP_SIZE = 90
    private let MINIMUM_PIPE_HEIGHT = 150
    static let CATEGORY_BIT_MASK: UInt32 = 0x1
    var upperPipe: Pipe
    var bottomPipe: Pipe
    var scoreNode: ScoreNode?
    var xPosition: Int {
        get {
            return Int(upperPipe.frame.maxX)
        }
    }
    
    init(startingXPosition: Int, obstacleGapYPosition: Int, bottomPipeTexture: SKTexture, upperPipeTexture: SKTexture) {
        bottomPipe = Pipe(
            xPosition: startingXPosition,
            yPosition: obstacleGapYPosition - Pipe.PIPE_HEIGHT/2,
            imageTexture: bottomPipeTexture)
        upperPipe = Pipe(
            xPosition: startingXPosition,
            yPosition: bottomPipe.yPosition + Pipe.PIPE_HEIGHT + GAP_SIZE,
            imageTexture: upperPipeTexture)
        scoreNode = ScoreNode(
            xPosition: startingXPosition,
            yPosition: obstacleGapYPosition + GAP_SIZE/2,
            height: GAP_SIZE)
    }
    
    init(screenSize: CGSize, bottomPipeTexture: SKTexture, upperPipeTexture: SKTexture) {
        let randomHeightPosition = Int.random(in: MINIMUM_PIPE_HEIGHT...Int(screenSize.height)-MINIMUM_PIPE_HEIGHT - GAP_SIZE)
        let startingXPosition = Int(screenSize.width + 150)
        bottomPipe = Pipe(
            xPosition: startingXPosition,
            yPosition: randomHeightPosition - Pipe.PIPE_HEIGHT/2,
            imageTexture: bottomPipeTexture)
        upperPipe = Pipe(
            xPosition: startingXPosition,
            yPosition: bottomPipe.yPosition + Pipe.PIPE_HEIGHT + GAP_SIZE,
            imageTexture: upperPipeTexture)
        scoreNode = ScoreNode(
            xPosition: startingXPosition,
            yPosition: randomHeightPosition + GAP_SIZE/2,
            height: GAP_SIZE)
    }
}
