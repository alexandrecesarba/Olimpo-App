//
//  ProfileGameCenter.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/02/23.
//

import Foundation
import UIKit
import GameKit

class ProfileGameCenter: UIViewController {

    let button = UIButton(type: .system)
    let button2 = UIButton(type: .system)


    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView()
        button.frame = CGRect(x: 20, y: 20, width: 100, height: 50)

        // Set text on button
        button.setTitle("Leaderboards", for: .normal)

        // Set button action
        button.addTarget(self, action: #selector(showLeaderboards), for: .touchUpInside)

        button2.frame = CGRect(x: 20, y: 50, width: 100, height: 50)

        // Set text on button
        button2.setTitle("Submit", for: .normal)

        // Set button action
        button2.addTarget(self, action: #selector(submitScore), for: .touchUpInside)


        view.addSubview(button)
        view.addSubview(button2)
        self.view = view

    }

    @objc private func showLeaderboards(_ sender: UIButton!) {
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        vc.viewState = .leaderboards
        vc.leaderboardIdentifier = "juggling"
        present(vc, animated: true, completion: nil)

    }

    @objc func submitScore(_ sender: UIButton!){
        let score = GKScore(leaderboardIdentifier: "juggling")
        score.value = Int64(EventMessenger.shared.lastScore)
        GKScore.report([score]){
            error in guard error == nil else{
                print(error?.localizedDescription ?? "")
                return
            }
            print("Score sent!")
        }
    }
}

extension ProfileGameCenter: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
