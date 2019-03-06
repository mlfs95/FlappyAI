//
//  GameSceneController.swift
//  FlappyAI
//
//  Created by Matheus on 25/02/19.
//  Copyright © 2019 Matheus Lourenco Fernandes Soares. All rights reserved.
//

import Foundation
import SpriteKit
import CoreML

class GameScene: SKScene, SKPhysicsContactDelegate {
    var gameSceneDelegate: GameSceneDelegate?
    
    override init() {
        super.init(size: CGSize(width: 600, height: 600))
    }
    
    override func didMove(to view: SKView) {
        self.physicsBody?.friction = 0
        self.scaleMode = .resizeFill
        self.backgroundColor = SKColor.gray
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        self.physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if  ((contact.bodyA.node?.name?.starts(with: "Bird")) ?? false &&
            (contact.bodyB.node?.name == "Pipe" || contact.bodyB.node?.name == "Border")) ||
            ((contact.bodyA.node?.name == "Pipe" || contact.bodyA.node?.name == "Border") &&
            contact.bodyB.node?.name?.starts(with: "Bird") ?? false) {
            var nodeName = contact.bodyA.node?.name
            if !nodeName!.starts(with: "Bird") {
                nodeName = contact.bodyB.node?.name
            }
            let index = String(nodeName?.dropFirst(4) ?? "-1")
            self.gameSceneDelegate?.birdDiedWith(index: Int(index) ?? -1)
            return
        }
        
        if  (contact.bodyA.node?.name == "Wall" && contact.bodyB.node?.name == "Pipe") ||
            (contact.bodyA.node?.name == "Pipe" && contact.bodyB.node?.name == "Wall") {
            self.gameSceneDelegate?.pipesShouldBeRemoved()
            return
        }
        
        if  (contact.bodyA.node?.name == "Bird" && contact.bodyB.node?.name == "Score Node") ||
            (contact.bodyA.node?.name == "Score Node" && contact.bodyB.node?.name == "Bird") {
            self.gameSceneDelegate?.didPassByPipe()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol GameSceneDelegate {
    func didPassByPipe()
    func birdDiedWith(index: Int)
    func pipesShouldBeRemoved()
}

extension GameSceneDelegate {
    func didPassByPipe() { print("didPassByPipe() not implemented") }
    func birdDiedWith(index: Int) { print("birdDied() not implemented") }
    func pipesShouldBeRemoved() { print("pipesShouldBeRemoved() not implemented") }
}
