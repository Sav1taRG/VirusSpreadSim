//
//  SimulationViewModel.swift
//  VirusSpreadSim
//
//  Created by Roman Golubinko on 09.05.2023.
//

import Foundation

class SimulationViewModel {
    
    private let simulation: Simulation
    
    var groupSize: Int {
        return simulation.groupSize
    }
    
    var gridSize: Int {
        return simulation.gridSize
    }
    
    var onUpdate: (() -> Void)?
    
    init(groupSize: Int, infectionFactor: Int, updateTimer: TimeInterval) {
        self.simulation = Simulation(groupSize: groupSize, infectionFactor: infectionFactor, updateTimer: updateTimer)
        self.simulation.delegate = self
    }
    
    func startSimulation() {
        simulation.delegate = self
        simulation.start()
    }
    
    func stopSimulation() {
        simulation.stop()
        simulation.delegate = nil
    }
    
    func infectPerson(at index: Int) {
        simulation.infectPerson(at: index)
    }
    
    func personViewModel(atRow row: Int, atColumn column: Int) -> PersonViewModel {
        let person = simulation.people.first { $0.row == row && $0.column == column }!
        return PersonViewModel(person: person)
    }
    
    func personViewModel(at index: Int) -> PersonViewModel {
        let row = index / gridSize
        let column = index % gridSize
        if let person = simulation.findPerson(atRow: row, atColumn: column) {
            return PersonViewModel(person: person)
        } else {
            fatalError("Could not find person at row \(row) and column \(column)")
        }
    }

    
    func healthyCount() -> Int {
        return simulation.people.filter { $0.state == .healthy }.count
    }
    
    func sickCount() -> Int {
        return simulation.people.filter { $0.state == .sick }.count
    }
    
}

// MARK: - SimulationDelegate
extension SimulationViewModel: SimulationDelegate {
    func simulationDidUpdate() {
        onUpdate?()
    }
}
