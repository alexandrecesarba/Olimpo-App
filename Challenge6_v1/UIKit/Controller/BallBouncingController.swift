//
//  GameViewController.swift
//  BouncingBall
//
//  Created by Felipe Gameleira on 07/02/23.
//

import UIKit
import SpriteKit
import GameplayKit

class BallBouncingController: UIViewController {
    let viewConverted = SKView(frame: UIScreen.main.bounds)
    let scene = SKScene(fileNamed: "BallBouncingScene")!
    let missingBallTextView = UILabel()
    let instructionTextView = UILabel()
    let alertImageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle.fill")!)
    
    override func loadView() {
        viewConverted.addSubview(missingBallTextView)
        viewConverted.addSubview(instructionTextView)
        viewConverted.addSubview(alertImageView)
        view = viewConverted
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSKSceneAndView()
        alertImageConfiguration()
        alertImageConstraints()
        ballMissingConfiguration()
        ballMissingConstraints()
        instructionTextConfiguration()
        instructionTextConstraints()
        self.view = viewConverted
        
    }
    
    func alertImageConfiguration(){
        alertImageView.tintColor = .systemOrange
        alertImageView.contentMode = .scaleAspectFit
    }
    
    func alertImageConstraints(){
        alertImageView.translatesAutoresizingMaskIntoConstraints = false
        alertImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        alertImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        alertImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.16).isActive = true
        alertImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.16).isActive = true
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
        instructionTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        instructionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
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
        missingBallTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        missingBallTextView.topAnchor.constraint(equalTo: alertImageView.bottomAnchor, constant: 20).isActive = true
        missingBallTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        missingBallTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    func configSKSceneAndView(){
        scene.scaleMode = .aspectFill
        viewConverted.allowsTransparency = true
        viewConverted.presentScene(scene)
        scene.view!.allowsTransparency = true
        scene.backgroundColor = .black.withAlphaComponent(0.7)
        viewConverted.ignoresSiblingOrder = true
//        viewConverted.showsFPS = true
//        viewConverted.showsNodeCount = true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
