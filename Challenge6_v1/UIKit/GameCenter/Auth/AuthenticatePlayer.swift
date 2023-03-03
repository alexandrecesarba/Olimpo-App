//
//  AuthenticatePlayer.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 27/02/23.
//

import Foundation
import GameKit
import UIKit


class AuthenticatePlayer: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        authenticatePlayer()
    }

    private func authenticatePlayer() {
        let player = GKLocalPlayer.local

        player.authenticateHandler = {vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }

            if let vc = vc {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }

}


extension AuthenticatePlayer: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
