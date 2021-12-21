//
//  Border.swift
//  FlappyAI
//
//  Created by Matheus on 26/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class Border: SKSpriteNode {
    static let BORDER_HEIGTH = 30
    static let BORDER_WIDTH = 10000
    var xPosition = 0
    var yPosition: Int
    
    init(color: UIColor, yPosition: Int) {
        self.yPosition = yPosition
        super.init(texture: nil, color: color, size: CGSize(width: Border.BORDER_WIDTH, height: Border.BORDER_HEIGTH))
        setupSprite()
    }
    
    init(texture: SKTexture, xPosition: Int, yPosition: Int, size: CGSize, screenWidth: CGFloat) {
        self.xPosition = xPosition
        self.yPosition = yPosition
        super.init(texture: texture, color:  UIColor.clear, size: size)
        setupSprite()
    }
    
    private func setupSprite() {
        self.name = "Border"
        self.position = CGPoint(x: Int(self.xPosition), y: self.yPosition)
        
        self.zPosition = 2
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody!.isDynamic = false
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.categoryBitMask = CategoryBitMask.BORDER.rawValue
        self.physicsBody!.collisionBitMask = CategoryBitMask.NO_CATEGORY.rawValue
        self.physicsBody!.contactTestBitMask = CategoryBitMask.BIRD.rawValue
        self.physicsBody!.linearDamping = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
