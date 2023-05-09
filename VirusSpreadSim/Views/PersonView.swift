//
//  PersonView.swift
//  VirusSpreadSim
//
//  Created by Roman Golubinko on 09.05.2023.
//

import UIKit

class PersonView: UIView {
    
    var state: PersonState = .healthy {
        didSet {
            updateAppearance()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = bounds.width / 2
        updateAppearance()
    }
    
    private func updateAppearance() {
        switch state {
        case .healthy:
            backgroundColor = .systemGreen
        case .sick:
            backgroundColor = .systemRed
        }
    }
}
