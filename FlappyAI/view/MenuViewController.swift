//
//  ViewController.swift
//  FlappyAI
//
//  Created by Matheus on 05/03/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBAction func playerModeTouched(_ sender: Any) {
        let gameViewController = GameViewController()
        gameViewController.gameMode = GameMode.PLAYER_MODE
        self.present(gameViewController, animated: true)
    }
    
    @IBAction func aiModeTouched(_ sender: Any) {
        let gameViewController = GameViewController()
        gameViewController.gameMode = GameMode.AI_MODE
        self.present(gameViewController, animated: true)
    }
}
