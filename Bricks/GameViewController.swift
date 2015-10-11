//
//  GameViewController.swift
//  Bricks
//
//  Created by NGO SON on 2015/09/30.
//  Copyright (c) 2015年 NGO SON. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene: GameScene!
    var bricks: Bricks!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        //Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick
        
        bricks = Bricks()
        bricks.beginGame()
        
        //Present the scene.
        skView.presentScene(scene)
        
        scene.addPreviewShapeToScene(bricks.nextShape!) {
            self.bricks.nextShape?.moveTo(StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(self.bricks.nextShape!) {
                let nextShapes = self.bricks.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(nextShapes.nextShape!) {}
            }
        }

    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func didTick() {
        bricks.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(bricks.fallingShape!, completion: {})
    }
}
