//
//  FloorLineView.swift
//  Challenge6_v1
//
//  Created by Felipe Gameleira on 14/02/23.
//

import Foundation
import UIKit

class FloorLineView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

