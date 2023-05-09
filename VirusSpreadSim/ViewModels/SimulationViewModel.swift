//
//  SimulationViewModel.swift
//  VirusSpreadSim
//
//  Created by Roman Golubinko on 09.05.2023.
//

import Foundation

class SimulationViewModel {
    
    private var simulation: Simulation
    
    var groupSize: Int {
        return simulation.groupSize
    }
    
    var gridSize: Int {
        return simulation.gridSize
    }
    
    init(groupSize: Int, infectionFactor: Int, updateTimer: TimeInterval) {
        self.simulation = Simulation(groupSize: groupSize, infectionFactor: infectionFactor, updateTimer: updateTimer)
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
    
    func personViewModel(at index: Int) -> PersonViewModel {
        let person = simulation.people[index]
        return PersonViewModel(person: person)
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
        // Notify the view to update the UI
    }
}