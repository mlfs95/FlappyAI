//
//  Wall.swift
//  FlappyAI
//
//  Created by Matheus on 26/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class Wall: SKSpriteNode {
    static let WALL_HEIGHT = 100
    static let WALL_WIDTH = 30
    var yPosition = 0
    var xPosition = -150
    
    init(){
        super.init(texture: nil, color: .black, size: CGSize(width: Wall.WALL_WIDTH, height: Wall.WALL_HEIGHT))
        
        self.name = "Wall"
        self.position = CGPoint(x: self.xPosition, y: self.yPosition)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody!.isDynamic = false
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.categoryBitMask = CategoryBitMask.WALL.rawValue
        self.physicsBody!.collisionBitMask = CategoryBitMask.NO_CATEGORY.rawValue
        self.physicsBody!.contactTestBitMask = CategoryBitMask.PIPE.rawValue
        self.physicsBody!.linearDamping = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
