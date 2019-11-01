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
    
    var gridLeitura = [[BoxCelula]]()
    var gridAlteracao = [[BoxCelula]]()
    
    override init() {
        super.init()
        
        let tamanho: Int = 5
        
        createMatrix(tamanho: tamanho)
        
    }
    
    func createMatrix(tamanho:Int) {
        let offset: Int = 8
        
        for x in 0...tamanho-1 {
            var row = [BoxCelula]()
            for y in 0...tamanho-1 {
                let cell = BoxCelula()
                cell.position.x = Float(x - offset)
                cell.position.y = Float(y - offset)
                row.append(cell)
                self.rootNode.addChildNode(cell)
            }
            gridLeitura.append(row)
        }   
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

