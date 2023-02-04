//
//  ResetButton.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 03/02/23.
//

import Foundation
import UIKit

class ResetButtonView: UIButton {
    
    func configButton(){
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.titleLabel?.textAlignment = .center
        self.setTitle("Reset Score", for: .normal)
        self.setTitleColor(.black, for: .normal)
        //        resetButton.frame = CGRect(x: 20, y: UIScreen.screens.first!.bounds.size.height - 100, width: UIScreen.screens.first!.bounds.size.width - 30, height: 60)
        self.translatesAutoresizingMaskIntoConstraints = false
//            resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

