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
    var gridGeracao: [[[BoxCelula]]] = []
    let tamanho: Int = 8
    
    override init() {
        super.init()
        createMatrix(tamanho: tamanho)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Criando matriz
    func createMatrix(tamanho:Int) {
        gridGeracao.append([[BoxCelula]]())
        
        for x in 0...tamanho-1 {
            var row = [BoxCelula]()
            for y in 0...tamanho-1 {
                let cell = BoxCelula(x: x, y: y, z: 0)
                row.append(cell)
                self.rootNode.addChildNode(cell)
            }
            gridLeitura.append(row)
            gridGeracao.append(gridLeitura)
        }   
    }
    
    func createMatrixGeracao(tamanho:Int, celula: [[BoxCelula]], zGeracao: Int) {
        let z = zGeracao
        for x in 0...tamanho-1 {
            for y in 0...tamanho-1 {
                let cell = celula[x][y]
                cell.position = SCNVector3(x: Float(x),y: Float(y),z: Float(Double(z)) * (0.8 + 0.1))
                
                if cell.state == .alive {
                    self.rootNode.addChildNode(cell)
                }
            }
        }
    }
    
    func gerarCamadaZ(zGeracao: Int) {
        let cellZ = updateGrid(grid: gridLeitura, z: zGeracao)
        createMatrixGeracao(tamanho: tamanho, celula: cellZ, zGeracao: zGeracao)
        
    }
    
    //Atualizando a grid
    func updateGrid(grid: [[BoxCelula]], z: Int) -> [[BoxCelula]] {
        
        var gridAlteracao = [[BoxCelula]]()
        var count: Int
        
        for i in 0..<tamanho {
            gridAlteracao.append([])
            for j in 0..<tamanho {
                gridAlteracao[i].append(grid[i][j].copy(cell: grid[i][j], z: z))
                count = countNeighbour(celula: grid[i][j])
                
                //regras
                if grid[i][j].state == .alive {
                    if count <= 1 || count >= 4 {
                        gridAlteracao[i][j].state = .dead
                    }
                } else if grid[i][j].state == .dead {
                    if count == 3 {
                        gridAlteracao[i][j].state = .alive
                    }
                }
                
            }
        }
        gridLeitura = gridAlteracao
        return gridLeitura
    }
    
    // remover grid da tela
    func removerGrid() {
        for x in self.gridLeitura {
            for y in x {
                y.removeFromParentNode()
            }
        }
    }
    
    // adicionando grid na tela
    func addGrid() {
        for x in 0..<gridLeitura.count {
            for y in 0..<gridLeitura[x].count {
                self.rootNode.addChildNode(gridLeitura[x][y])
            }
        }
    }
    
    func resetGrid() {
        removerGrid()
        createMatrix(tamanho: 8)
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
}
