//
//  SimulationViewController.swift
//  VirusSpreadSim
//
//  Created by Roman Golubinko on 09.05.2023.
//

import UIKit

class SimulationViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pinchGestureRecognizer: UIPinchGestureRecognizer!
    
    var simulationViewModel: SimulationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SimulationViewController viewDidLoad called")
        print("simulationViewModel: \(simulationViewModel)")
        collectionView.dataSource = self
        collectionView.delegate = self
        scrollView.delegate = self
        simulationViewModel.onUpdate = { [weak self] in
            self?.collectionView.reloadData()
        }
        simulationViewModel.startSimulation()
    }
    
    @IBAction func pinchGestureHandler(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let currentScale = collectionView.layer.contentsScale
            let newScale = currentScale * sender.scale
            let minScale: CGFloat = 0.5
            let maxScale: CGFloat = 5.0
            
            collectionView.layer.contentsScale = min(max(minScale, newScale), maxScale)
            collectionView.reloadData()
            sender.scale = 1
        }
    }
    
}

extension SimulationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return simulationViewModel.groupSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCollectionViewCell
        let personViewModel = simulationViewModel.personViewModel(at: indexPath.item)
        cell.configure(with: personViewModel)
        return cell
    }
}

extension SimulationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        simulationViewModel.infectPerson(at: indexPath.item)
        collectionView.reloadItems(at: [indexPath])
    }
}

extension SimulationViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return collectionView
    }
}

extension SimulationViewController: SimulationDelegate {
    func simulationDidUpdate() {
        collectionView.reloadData()
    }
}

