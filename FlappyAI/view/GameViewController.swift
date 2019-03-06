//
//  GameViewController.swift
//  FlappyAI
//
//  Created by Matheus on 19/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var playerGameController: PlayerGameController!
    var aiGameController: AIGameController!
    var gameMode: GameMode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if gameMode == .PLAYER_MODE {
            playerGameController = PlayerGameController(view: self)
        }
        if gameMode == .AI_MODE {
            aiGameController = AIGameController(view: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameMode == .PLAYER_MODE {
            playerGameController.touchBegan()
        }
    }
    
    @IBAction func quitButtonTouched(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
