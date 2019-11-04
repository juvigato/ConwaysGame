//
//  BoxCelula.swift
//  conwayGame
//
//  Created by Juliana Vigato Pavan on 01/11/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import SceneKit

class BoxCelula: SCNNode {
    
    var state:State = .dead
    var neighbours: Int = 0
    
    override init() {
        super.init()
        
        let geometryBox = SCNBox(width: 0.5, height: 0.5, length: 0.08, chamferRadius: 0.005)
        self.geometry = geometryBox
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }    
}

enum State {
    case alive
    case dead
}
