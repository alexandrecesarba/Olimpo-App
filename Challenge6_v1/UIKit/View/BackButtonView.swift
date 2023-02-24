//
//  BackButtonView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 23/02/23.
//

import Foundation
import UIKit

class BackButtonView: UIView {
    
    let backImage = UIImage(systemName: "chevron.left")!
    let backButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)
        backButtonConfiguration()
        backButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func backButtonConfiguration() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.imageView?.image = backImage
        backButton.layer.masksToBounds = true
        backButton.imageView?.layer.masksToBounds = true
        backButton.tintColor = .white
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.contentMode = .scaleAspectFill
//      backButtonon.backgroundColor = .red
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.setImage(backImage, for: .normal)
    }
    
    func backButtonConstraints() {
        backButton.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

