//
//  File.swift
//  FlappyAI
//
//  Created by Matheus on 19/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class Bird: SKSpriteNode {
    static let BIRD_HEIGHT = 18
    static let BIRD_WIDTH = 30
    static let BIRD_X_POSITION = 40
    let imageNamed = "bird"
    var yPosition = 300
    
    init() {
        let imageTexture = SKTexture(imageNamed: imageNamed)
        super.init(texture: imageTexture, color: UIColor.clear, size: imageTexture.size())
        
        self.name = "Bird"
        self.position = CGPoint(x: Bird.BIRD_X_POSITION, y: yPosition)
        self.size = CGSize(width: Bird.BIRD_WIDTH, height: Bird.BIRD_HEIGHT)
        
        self.physicsBody = SKPhysicsBody(texture: imageTexture, size: self.size)
        self.physicsBody!.isDynamic = true
        self.physicsBody!.affectedByGravity = true
        self.physicsBody!.allowsRotation = true
        self.physicsBody!.categoryBitMask = CategoryBitMask.BIRD.rawValue
        self.physicsBody?.collisionBitMask = CategoryBitMask.NO_CATEGORY.rawValue
        self.physicsBody!.contactTestBitMask = CategoryBitMask.PIPE.rawValue | CategoryBitMask.BORDER.rawValue
    }
    
    func jump() {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 3.5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
