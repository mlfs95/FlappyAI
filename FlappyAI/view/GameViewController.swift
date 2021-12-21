//
//  GameViewController.swift
//  FlappyAI
//
//  Created by Matheus on 19/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var playerGameController: PlayerGameController!
    var aiGameController: AIGameController!
    var versusGameController: VersusGameController!
    var gameMode: GameMode!
    private var textureAtlas = SKTextureAtlas(named: "Flappy")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene()
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true

        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true

        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .aspectFill
        scene.size = self.view.frame.size    //<---HERE
        skView.presentScene(scene)

        if gameMode == .PLAYER_MODE {
            playerGameController = PlayerGameController(view: self, gameScene: scene, textureAltas: textureAtlas)
        }
        if gameMode == .AI_MODE {
            aiGameController = AIGameController(view: self, gameScene: scene, textureAltas: textureAtlas)
        }
        if gameMode == .VERSUS_MODE {
            versusGameController = VersusGameController(view: self, gameScene: scene, textureAltas: textureAtlas)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameMode == .PLAYER_MODE{
            playerGameController.touchBegan()
        }
        if gameMode == .VERSUS_MODE{
            versusGameController.touchBegan()
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
