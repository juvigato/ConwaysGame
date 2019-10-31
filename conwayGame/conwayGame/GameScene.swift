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
        
        
        let offset: Int = 8
        
        for i in 0...10 {
            for j in 0...16 {
                let geometry = SCNBox(width: 0.5, height: 0.5, length: 0.08, chamferRadius: 0.005)
//                geometry.firstMaterial?.diffuse.contents = UIColor.white
//                geometry.firstMaterial?.emission.contents = UIColor.blue
                let boxNode = SCNNode(geometry: geometry)
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
