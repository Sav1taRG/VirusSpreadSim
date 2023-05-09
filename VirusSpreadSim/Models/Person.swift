//
//  Person.swift
//  VirusSpreadSim
//
//  Created by Roman Golubinko on 09.05.2023.
//

import Foundation

class Person {
    let id: UUID
    let row: Int
    let column: Int
    var state: PersonState
    
    init(id: UUID = UUID(), row: Int, column: Int, state: PersonState = .healthy) {
        self.id = id
        self.row = row
        self.column = column
        self.state = state
    }
}

enum PersonState {
    case healthy
    case sick
}
