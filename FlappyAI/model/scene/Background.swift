//
//  background.swift
//  FlappyAI
//
//  Created by Matheus Soares on 20/12/21.
//  Copyright © 2021 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode {
    let xPosition: CGFloat
    let yPosition: CGFloat
    let height: CGFloat
    let width: CGFloat
    
    init(texture: SKTexture, screenFrame: CGRect) {
        self.xPosition = screenFrame.width/2
        self.yPosition = screenFrame.height/2
        self.height = screenFrame.height
        self.width = screenFrame.height*59.27/25.4
        super.init(texture: texture, color:  UIColor.clear, size: CGSize(width: self.width, height: self.height))
        setupSprite()
    }
    
    private func setupSprite() {
        self.name = "Background"
        self.position = CGPoint(x: self.xPosition, y: self.yPosition)
        
        self.zPosition = 0
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody!.isDynamic = false
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

