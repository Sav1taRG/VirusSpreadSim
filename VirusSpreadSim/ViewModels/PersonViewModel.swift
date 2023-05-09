//
//  PersonViewModel.swift
//  VirusSpreadSim
//
//  Created by Roman Golubinko on 09.05.2023.
//

class PersonViewModel {
    private let person: Person
    var state: PersonState {
        return person.state
    }
    
    init(person: Person) {
        self.person = person
    }
    
    func infect() {
        person.state = .sick
    }
    
}
