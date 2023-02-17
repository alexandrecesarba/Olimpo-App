//
//  CameraSwitchView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 09/02/23.
//

import Foundation
import UIKit

class CameraSwitchView: UIView {
    
    let button = UIButton(type: .custom)
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor

    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteCircle.withAlphaComponent(0.2)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(getCameraSwitchButton())
        self.button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        self.button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCameraSwitchButton () -> UIButton {
        button.layer.masksToBounds = true
        button.imageView?.layer.masksToBounds = true
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.contentMode = .scaleAspectFill
//        button.backgroundColor = .red
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath.camera")!, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }
}


