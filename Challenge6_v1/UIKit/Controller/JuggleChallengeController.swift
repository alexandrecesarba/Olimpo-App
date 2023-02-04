//
//  JuggleChallengeController.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 03/02/23.
//

import Foundation
import UIKit

class JuggleChallengeController: UIViewController {
    
    let model = JuggleChallengeModel(target: 10)
    let juggleChallengeView = JuggleChallengeView()
    
    override func loadView() {
        super.loadView()
        view = juggleChallengeView
        juggleChallengeView.directionView.text = model.direction.rawValue.capitalized
        juggleChallengeView.targetView.text = "Target: \(model.target)"
        
    }
    
    
}
