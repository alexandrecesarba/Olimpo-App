//
//  RoundedLabelView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 03/02/23.
//

import Foundation
import UIKit

class RoundedLabelView {
    static func create(name: String, textColor: UIColor = .black, backgroundColor: UIColor = UIColor.white.withAlphaComponent(0.5), textAlignment: NSTextAlignment = .center, fontSize: CGFloat = 12) -> UILabel {
        let roundedLabel:UILabel = {
            let roundedLabel = UILabel()
            roundedLabel.layer.cornerRadius = 20
            roundedLabel.layer.masksToBounds = true
            roundedLabel.backgroundColor = backgroundColor
            roundedLabel.text = name
            roundedLabel.textAlignment = textAlignment
            roundedLabel.textColor = textColor
            roundedLabel.font = UIFont.systemFont(ofSize: fontSize)
            roundedLabel.translatesAutoresizingMaskIntoConstraints = false
            return roundedLabel
        }()
        return roundedLabel
    }
    
}
