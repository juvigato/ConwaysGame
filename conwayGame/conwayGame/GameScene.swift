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
    
    let tamanho: Int = 8
    
    override init() {
        super.init()
        createMatrix(tamanho: tamanho)
    }
    
    //Criando matriz
    func createMatrix(tamanho:Int) {
        
        for x in 0...tamanho-1 {
            var row = [BoxCelula]()
            for y in 0...tamanho-1 {
                let cell = BoxCelula(x: x, y: y)
                row.append(cell)
                self.rootNode.addChildNode(cell)
            }
            gridLeitura.append(row)
        }   
    }
    
    //Atualizando a grid
    func updateGrid() {
        
        var gridAlteracao = [[BoxCelula]]()
        var cell: BoxCelula
        var count: Int
        
        for i in 0..<tamanho {
            gridAlteracao.append([BoxCelula]())
            for j in 0..<tamanho {
                cell = gridLeitura[i][j]
                count = countNeighbour(celula: cell)
                let newCell = cell.copy(cell: cell)
                
                //regras
                if newCell.state == .alive {
                    if count <= 1 || count >= 4 {
                        newCell.state = .dead
                    }
                } else {
                    if count == 3 {
                        newCell.state = .alive
                    }
                }
                gridAlteracao[i].append(newCell)
            }
        }
        removerGrid()
        gridLeitura = gridAlteracao
        addGrid()
    }
    
    func removerGrid() {
        for x in self.gridLeitura {
            for y in x {
                y.removeFromParentNode()
            }
        }
    }
    
    func addGrid() {
        for x in 0..<gridLeitura.count {
            for y in 0..<gridLeitura[x].count {
                self.rootNode.addChildNode(gridLeitura[x][y])
            }
        }
    }
    
    //Contando quantos vizinhos um node possui
    func countNeighbour(celula: BoxCelula) -> Int {
        var count: Int = 0
        var i: Float = celula.position.x - 1
        
        while i <= celula.position.x + 1 {
            var j: Float = celula.position.y - 1
            
            while j <= celula.position.y + 1{
                if !(celula.position.x == i && celula.position.y == j) && i >= 0 && j >= 0 && Int(i) < tamanho && Int(j) < tamanho {
                    //verificar se vivo
                    if gridLeitura[Int(i)][Int(j)].state == .alive {
                        count = count + 1
                        
                    }
                }
                j = j + 1
            }
            i = i + 1
        }
        celula.neighbours = count
        return count
    }
    
    //Adicionando regras
//    func addRule() {
//        rules.append(Rules(inicialValue: .alive, finalValue: .dead, minValue: 0, maxValue: 1))
//        rules.append(Rules(inicialValue: .alive, finalValue: .dead, minValue: 4, maxValue: 8))
//        rules.append(Rules(inicialValue: .alive, finalValue: .alive, minValue: 2, maxValue: 3))
//        rules.append(Rules(inicialValue: .dead, finalValue: .alive, minValue: 3, maxValue: 3))
//    }
    
    func teste(){
        for i in 0..<tamanho {
            for j in 0..<tamanho {
                if gridLeitura[i][j].state == .alive {
                    print("1", separator: " ", terminator: " ")
                } else {
                    print("0", separator: " ", terminator: " ")
                }
            }
            print(" ")
        }
        print(" ")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
