//
//  ParametersViewController.swift
//  VirusSpreadSim
//
//  Created by Roman Golubinko on 09.05.2023.
//

import UIKit

class ParametersViewController: UIViewController {
    
    var simulationViewModel: SimulationViewModel?
    
    @IBOutlet var groupSizeTF: UITextField!
    @IBOutlet var infectionFactorTF: UITextField!
    @IBOutlet var updateTimerTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startSimButtonPressed(_ sender: UIButton) {
        guard let groupSizeText = groupSizeTF.text, !groupSizeText.isEmpty,
              let groupSize = Int(groupSizeText),
              let infectionFactorText = infectionFactorTF.text, !infectionFactorText.isEmpty,
              let infectionFactor = Int(infectionFactorText),
              let updateTimerText = updateTimerTF.text, !updateTimerText.isEmpty,
              let updateTimer = TimeInterval(updateTimerText) else {
            showAlert(title: "Invalid Output", message: "Please enter valid parameters")
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
           let destinationVC = segue.destination as? SimulationViewController {
            if let viewModel = sender as? SimulationViewModel {
                destinationVC.simulationViewModel = viewModel
            } else {
                // set simulationViewModel to a default value if sender is nil
                let defaultViewModel = SimulationViewModel(
                    groupSize: 25,
                    infectionFactor: 3,
                    updateTimer: 1.0
                )
                destinationVC.simulationViewModel = defaultViewModel
            }
        }
    }

    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

