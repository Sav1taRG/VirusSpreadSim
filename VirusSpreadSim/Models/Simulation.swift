//
//  Simulation.swift
//  VirusSpreadSim
//
//  Created by Roman Golubinko on 09.05.2023.
//

import Foundation

protocol SimulationDelegate: AnyObject {
    func simulationDidUpdate()
}

class Simulation {
    var groupSize: Int
    var infectionFactor: Int
    var updateTimer: TimeInterval
    var people: [Person]
    var gridSize: Int {
        return Int(sqrt(Double(groupSize)))
    }
    weak var delegate: SimulationDelegate?
    
    
    private var timer: Timer?
    
    init(groupSize: Int, infectionFactor: Int, updateTimer: TimeInterval) {
        self.groupSize = groupSize
        self.infectionFactor = infectionFactor
        self.updateTimer = updateTimer
        self.people = []
       
        let numberOfRows = gridSize
        let numberOfColumns = gridSize
        
        print("gridSize: \(gridSize)")
        print("numberOfRows: \(numberOfRows), numberOfColumns: \(numberOfColumns)")
        
        for row in 0..<numberOfRows {
            for column in 0..<numberOfColumns {
                let person = Person(row: row, column: column)
                self.people.append(person)
            }
        }
        print("Total people count: \(people.count)")
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: updateTimer, repeats: true) { [weak self] _ in
            self?.updateSimulation()
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateSimulation() {
        var newSickPeople: [Person] = []
        
        for person in people {
            if person.state == .sick {
                let neighbors = findNeighbors(of: person)
                let newInfections = infectRandomNeighbors(neighbors: neighbors)
                newSickPeople.append(contentsOf: newInfections)
            }
        }
        
        for newSickPerson in newSickPeople {
            newSickPerson.state = .sick
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.simulationDidUpdate()
        }
    }
    
    private func findNeighbors(of person: Person) -> [Person] {
        let directions = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),           (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]
        
        var neighbors: [Person] = []
        for (dx, dy) in directions {
            let newRow = person.row + dx
            let newCol = person.column + dy
            
            if newRow >= 0 && newRow < gridSize && newCol >= 0 && newCol < gridSize {
                if let neighbor = findPerson(atRow: newRow, atColumn: newCol) {
                    neighbors.append(neighbor)
                }
            }
        }
        return neighbors
    }
    
    internal func findPerson(atRow row: Int, atColumn column: Int) -> Person? {
        return people.first { $0.row == row && $0.column == column }
    }
    
    private func infectRandomNeighbors(neighbors: [Person]) -> [Person] {
        let neighborsToInfect = min(neighbors.count, infectionFactor)
        let infectedNeighbors = Array(neighbors.shuffled().prefix(neighborsToInfect))
        return infectedNeighbors
    }
    
    func infectPerson(at index: Int) {
        guard index >= 0 && index < people.count else { return }
        people[index].state = .sick
    }
}
