//
//  CheckmarkView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 17/02/23.
//

import Foundation
import UIKit

class CheckmarkView: UIView {
    
    let checkmark: UIImageView = UIImageView(image: UIImage(systemName: "checkmark"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(checkmark)
        viewsConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func viewsConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.whiteCircle.cgColor
        self.layer.backgroundColor = UIColor.gray.cgColor
        self.checkmark.tintColor = .whiteCircle
        checkmark.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        checkmark.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        checkmark.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        checkmark.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true

    }
    
    
    
    func setBackgroundColor (_ color: UIColor){
        self.backgroundColor = color
    }
}
