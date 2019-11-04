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
    let tamanho: Int = 5
    var rules = [Rules]()
    
    override init() {
        super.init()
        addRule()
        createMatrix(tamanho: tamanho)
    }
    
    //Criando matriz
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
    
    //Atualizando a grid
    func updateGrid() {
        for i in 0..<tamanho {
            var row = [BoxCelula]()
            for j in 0..<tamanho {
                let cell = gridLeitura[i][j]
                countNeighbour(celula: cell)
                //applyRules (checkCases)
                
                row.append(cell)
            }
            gridAlteracao.append(row)
        }
        gridLeitura = gridAlteracao
    }
    
    //Contando quantos vizinhos um node possui
    func countNeighbour(celula: BoxCelula) {
        var count: Int = 0
        var i: Float = celula.position.x - 1
        
        while i < celula.position.x + 1 {
            var j: Float = celula.position.y - 1
            
            while j < celula.position.y + 1{
                if celula.position.x != i || celula.position.y != j
                    && i > 0 && j > 0 && Int(i) < tamanho && Int(j) < tamanho {
                    count = count + 1
                    celula.neighbours = count
                }
                j = j + 1
            }
            i = i + 1
        }
    }
    
    //Adicionando regras
    func addRule() {
        rules.append(Rules(inicialValue: .alive, finalValue: .dead, minValue: 0, maxValue: 1))
        rules.append(Rules(inicialValue: .alive, finalValue: .dead, minValue: 4, maxValue: 8))
        rules.append(Rules(inicialValue: .alive, finalValue: .alive, minValue: 2, maxValue: 3))
        rules.append(Rules(inicialValue: .dead, finalValue: .alive, minValue: 3, maxValue: 3))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

