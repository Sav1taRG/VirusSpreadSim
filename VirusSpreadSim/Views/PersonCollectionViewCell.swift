//
//  PersonCollectionViewCell.swift
//  VirusSpreadSim
//
//  Created by Roman Golubinko on 09.05.2023.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var personView: PersonView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        personView.layer.cornerRadius = personView.bounds.width / 2
    }
    
    func configure(with personViewModel: PersonViewModel) {
        personView.state = personViewModel.state
    }
}
