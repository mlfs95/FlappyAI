//
//  Pipe.swift
//  FlappyAI
//
//  Created by Matheus on 25/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

 class Pipe: SKSpriteNode{
    static let PIPE_HEIGHT = 650
    static let PIPE_WIDTH = 61
    var xPosition: Int
    var yPosition: Int
    
    init(xPosition: Int, yPosition: Int, imageTexture: SKTexture){
        self.xPosition = xPosition
        self.yPosition = yPosition
        
        super.init(texture: imageTexture, color: UIColor.clear, size: CGSize(width: Pipe.PIPE_WIDTH, height: Pipe.PIPE_HEIGHT))
        
        self.name = "Pipe"
        self.position = CGPoint(x: self.xPosition, y: self.yPosition)
        
        self.physicsBody = SKPhysicsBody(texture: imageTexture, size: self.size)
        self.physicsBody!.isDynamic = true
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.categoryBitMask = CategoryBitMask.PIPE.rawValue
        self.physicsBody!.collisionBitMask = CategoryBitMask.NO_CATEGORY.rawValue
        self.physicsBody!.contactTestBitMask = CategoryBitMask.BIRD.rawValue | CategoryBitMask.WALL.rawValue
        self.physicsBody!.velocity = CGVector(dx: -100, dy: 0)
        self.physicsBody!.linearDamping = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
