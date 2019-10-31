//
//  GameScene.swift
//  conwayGame
//
//  Created by Juliana Vigato Pavan on 31/10/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import SceneKit

class GameScene: SCNScene {
    override init() {
        super.init()
        
        let geometry = SCNBox(width: 0.5, height: 0.5, length: 0.08, chamferRadius: 0.005)
        geometry.firstMaterial?.diffuse.contents = UIColor.green
        geometry.firstMaterial?.emission.contents = UIColor.blue
//        geometry.firstMaterial?.specular.contents = UIColor.white
        let boxNode = SCNNode(geometry: geometry)
        let offset: Int = 16
        
        for i in 0...32 {
            for j in 0...32 {
                let boxCopy = boxNode.copy() as! SCNNode
                boxCopy.position.x = Float(i-offset)
                boxCopy.position.y = Float(j-offset)
                self.rootNode.addChildNode(boxCopy)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
