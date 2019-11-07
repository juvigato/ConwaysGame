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
    
    var color : UIColor
    var posicao: (Int, Int, Int)
    var geracao: Int

    var state:State {
        willSet{
            if newValue == .dead {
                //muda a cor para morto
                color = UIColor.systemGray
            } else if newValue == . alive{
                //mudar cor para vivo
                color = UIColor.systemPink
            } else {
                color = UIColor.systemBlue
            }
            geometry?.firstMaterial?.diffuse.contents = color
        }
    }
    
    var neighbours: Int = 0
    
    init(x: Int, y: Int, z:Int) {
        self.geracao = z
        posicao = (x,y,geracao)
        self.state = .dead
        self.color = .systemGray
        super.init()
        self.position = SCNVector3(x, y, 0)
        let geometryBox = SCNBox(width: 0.8, height: 0.8, length: 0.1, chamferRadius: 0.005)
        self.geometry = geometryBox
        geometryBox.firstMaterial?.diffuse.contents = color
    }
    
    func copy(cell: BoxCelula, z: Int) -> BoxCelula {
        let newCell = BoxCelula(x: posicao.0, y: posicao.1, z: z * Int((0.8 + 0.3)))
        newCell.state = cell.state
        newCell.geracao = cell.geracao
        newCell.geometry?.firstMaterial?.diffuse.contents = cell.color
        newCell.neighbours = cell.neighbours
        return newCell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum State {
    case alive
    case dead
    case dontExist
}
