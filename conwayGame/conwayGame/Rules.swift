//
//  Rules.swift
//  conwayGame
//
//  Created by Juliana Vigato Pavan on 04/11/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import SceneKit

class Rules: SCNScene {
    
    var inicialValue: State
    var finalValue: State
    var minValue: Int
    var maxValue: Int
    
    init(inicialValue: State , finalValue: State, minValue: Int, maxValue: Int) {
        self.inicialValue = inicialValue
        self.finalValue = finalValue
        self.minValue = minValue
        self.maxValue = maxValue
        super.init()
    }
    
    //funcao de checar os casos
//    func checkCases(states: State, count: Int) -> State{
//        if inicialValue == inicialValue && minValue == minValue && maxValue == maxValue {
//            
//            
//        }
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
