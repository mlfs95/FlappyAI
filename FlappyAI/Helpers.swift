//
//  Helpers.swift
//  FlappyAI
//
//  Created by Matheus on 26/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit

enum CategoryBitMask: UInt32 {
    case NO_CATEGORY = 0x0
    case BIRD = 0x1
    case PIPE = 0x10
    case WALL = 0x100
    case BORDER = 0x1000
    case SCORE_NODE = 0x10000
}

enum GameMode {
    case AI_MODE
    case PLAYER_MODE
}

class BaseSKLabel: SKLabelNode {
    override init() {
        super.init()
        self.zPosition = 2
        self.fontSize = 25
        self.color = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func width() -> CGFloat {
        return self.frame.size.width
    }
}
