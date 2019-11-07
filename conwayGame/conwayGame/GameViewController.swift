//
//  GameViewController.swift
//  conwayGame
//
//  Created by Juliana Vigato Pavan on 31/10/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
    
    // create a new scene
    let scene = GameScene()
    var zGeracao: Int = 0
    
    @IBOutlet weak var scnView: SCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the scene to the view
        scnView.scene = scene
        scnView.loops = true
        scnView.isPlaying = true
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
           
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 3.5, y: 3, z: 20)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        let ambientnode = SCNNode()
        ambientnode.light = SCNLight()
        ambientnode.light!.type = .ambient
        ambientnode.light?.color = UIColor.white
        scene.rootNode.addChildNode(ambientnode)
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
       
    //fazer botao por codigo
    @IBAction func startButton(_ sender: Any) {
//        scene.teste()
        scene.gerarCamadaZ() //colocar parametro z
        zGeracao += 1
    }
    
    @IBAction func resetButton(_ sender: Any) {
        scene.resetGrid()
    }

    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            
            let result = hitResults[0]
            
            let material = result.node.geometry!.firstMaterial!
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5

                SCNTransaction.commit()
            }
            
            
            if let node = result.node as? BoxCelula {
                
                switch node.state {
                case .alive:
                    material.diffuse.contents = node.color
                    node.state = .dead
                case .dead:
                    material.diffuse.contents = node.color
                    node.state = .alive
                case .dontExist:
                    node.state = .dontExist
                }
            }
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
}
