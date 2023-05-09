//
//  ParametersViewController.swift
//  VirusSpreadSim
//
//  Created by Roman Golubinko on 09.05.2023.
//

import UIKit

class ParametersViewController: UIViewController {
    
    @IBOutlet var groupSizeTF: UITextField!
    @IBOutlet var infectionFactorTF: UITextField!
    @IBOutlet var updateTimerTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startSimButtonPressed(_ sender: UIButton) {
        guard let groupSize = Int(groupSizeTF.text ?? ""),
              let infectionFactor = Int(infectionFactorTF.text ?? ""),
              let updateTimer = TimeInterval(updateTimerTF.text ?? "") else {
            showAlert(title: "Invalid Output", message: "Please ented valid parameters")
            return
        }
        
        let simulationViewModel = SimulationViewModel(
            groupSize: groupSize,
            infectionFactor: infectionFactor,
            updateTimer: updateTimer
        )
        
        performSegue(withIdentifier: "showSimulation", sender: simulationViewModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSimulation",
           let destinationVC = segue.destination as? SimulationViewController,
           let viewModel = sender as? SimulationViewModel {
            destinationVC.simulationViewModel = viewModel
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

