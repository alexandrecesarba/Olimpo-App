//
//  BallStatusView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 03/02/23.
//

import Foundation
import UIKit

class BallStatusView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.backgroundColor = .red.withAlphaComponent(0.5)
        self.text = "❌ Ball not found"
        self.textAlignment = .center
        self.textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

