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
    
    init() {
        super.init(color: .green, yPosition: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
