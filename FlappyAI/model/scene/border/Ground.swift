//
//  Ground.swift
//  FlappyAI
//
//  Created by Matheus on 26/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

class Ground: Border {
    
    init(groundTexture: SKTexture, screenWidth: CGFloat) {
        let height = 6.74 * screenWidth/30.73
        let size = CGSize(width: screenWidth, height: height)
        super.init(texture: groundTexture, xPosition: Int(screenWidth)/2, yPosition: Int(height)/4, size: size, screenWidth: screenWidth)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
