//
//  BallBouncingView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 08/02/23.
//

import Foundation
import UIKit
import SpriteKit

class BallBouncingView: SKView {
    let ballBouncingScene = SKScene(fileNamed: "BallBouncingScene")!
    let missingBallTextView = UILabel()
    let instructionTextView = UILabel()
    let alertImageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle.fill")!)
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addSubview(missingBallTextView)
        addSubview(instructionTextView)
        addSubview(alertImageView)
        configSKSceneAndView()
        alertImageConfiguration()
        alertImageConstraints()
        ballMissingConfiguration()
        ballMissingConstraints()
        instructionTextConfiguration()
        instructionTextConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func alertImageConfiguration(){
        alertImageView.tintColor = .alertOrange
        alertImageView.contentMode = .scaleAspectFit
    }
    
    func alertImageConstraints(){
        alertImageView.translatesAutoresizingMaskIntoConstraints = false
        alertImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        alertImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        alertImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.16).isActive = true
        alertImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.16).isActive = true
    }
    
    func instructionTextConfiguration() {
        instructionTextView.text = "Ensure the ball is within the\ncamera's range to keep playing!"
        instructionTextView.numberOfLines = 2
        instructionTextView.textAlignment = .center
        instructionTextView.font = UIFont.getRoundedFont(size: 18, weight: .regular)
        instructionTextView.textColor = .white
    }
    
    func instructionTextConstraints(){
        instructionTextView.translatesAutoresizingMaskIntoConstraints = false
        instructionTextView.topAnchor.constraint(equalTo: missingBallTextView.bottomAnchor, constant: 0).isActive = true
        instructionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        instructionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
//        instructionTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true

    }
    
    func ballMissingConfiguration() {
        missingBallTextView.text = "M I S S I N G  B A L L"
        missingBallTextView.textAlignment = .center
        missingBallTextView.font = UIFont.getRoundedFont(size: 24, weight: .medium)
        missingBallTextView.textColor = .white
//        explanatoryText.font
    }
    
    func ballMissingConstraints(){
        missingBallTextView.translatesAutoresizingMaskIntoConstraints = false
        missingBallTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        missingBallTextView.topAnchor.constraint(equalTo: alertImageView.bottomAnchor, constant: 20).isActive = true
        missingBallTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        missingBallTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    func configSKSceneAndView(){
        ballBouncingScene.scaleMode = .aspectFill
        self.allowsTransparency = true
        self.presentScene(ballBouncingScene)
        ballBouncingScene.view!.allowsTransparency = true
        ballBouncingScene.backgroundColor = .black.withAlphaComponent(0.9)
        self.ignoresSiblingOrder = true
//        viewConverted.showsFPS = true
//        viewConverted.showsNodeCount = true
    }
}
