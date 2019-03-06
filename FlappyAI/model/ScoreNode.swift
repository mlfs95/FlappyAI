//
//  ScoreNode.swift
//  FlappyAI
//
//  Created by Matheus on 26/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class ScoreNode: SKSpriteNode{
    private let WIDTH = 3
    var xPosition: Int
    var yPosition: Int
    
    init(xPosition: Int, yPosition: Int, height: Int){
        self.xPosition = xPosition
        self.yPosition = yPosition
        
        super.init(texture: nil, color: .clear, size: CGSize(width: WIDTH, height: height))
        
        self.name = "Score Node"
        self.position = CGPoint(x: self.xPosition, y: self.yPosition)
        
        self.zPosition = 2
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody!.isDynamic = true
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.categoryBitMask = CategoryBitMask.SCORE_NODE.rawValue
        self.physicsBody!.collisionBitMask = CategoryBitMask.NO_CATEGORY.rawValue
        self.physicsBody!.contactTestBitMask = CategoryBitMask.BIRD.rawValue
        self.physicsBody!.velocity = CGVector(dx: -100, dy: 0)
        self.physicsBody!.linearDamping = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
