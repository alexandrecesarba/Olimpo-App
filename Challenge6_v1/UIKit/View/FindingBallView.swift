//
//  FindingBallView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 14/02/23.
//

import Foundation
import UIKit

class FindingBallView: UIView {
    
    let keepSteadyTextView = UILabel()
    let instructionTextView = UILabel()
    let progressBarView = FindingProgressBar()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addSubview(progressBarView)
        addSubview(keepSteadyTextView)
        addSubview(instructionTextView)
       
        keepSteadyConfiguration()
        keepSteadyConstraints()
        instructionTextConfiguration()
        instructionTextConstraints()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func instructionTextConfiguration() {
        instructionTextView.text = "Keep you camera very still\nwhile the ball is still being detected"
        instructionTextView.numberOfLines = 2
        instructionTextView.textAlignment = .center
        instructionTextView.font = UIFont.getRoundedFont(size: 18, weight: .regular)
        instructionTextView.textColor = .white
    }
    
    func instructionTextConstraints(){
        instructionTextView.translatesAutoresizingMaskIntoConstraints = false
        instructionTextView.topAnchor.constraint(equalTo: keepSteadyTextView.bottomAnchor, constant: 0).isActive = true
        instructionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        instructionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
//        instructionTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true

    }
    
    func keepSteadyConfiguration() {
        keepSteadyTextView.text = "H O L D  S T E A D Y"
        keepSteadyTextView.textAlignment = .center
        keepSteadyTextView.font = UIFont.getRoundedFont(size: 24, weight: .medium)
        keepSteadyTextView.textColor = .white
//        explanatoryText.font
    }
    
    func keepSteadyConstraints(){
        keepSteadyTextView.translatesAutoresizingMaskIntoConstraints = false
        keepSteadyTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        keepSteadyTextView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        keepSteadyTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        keepSteadyTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
}
