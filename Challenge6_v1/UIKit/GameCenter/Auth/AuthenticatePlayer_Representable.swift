//
//  AuthenticatePlayerRepresentable.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 27/02/23.
//

import Foundation
import SwiftUI

struct AuthenticatePlayer_Representable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AuthenticatePlayer

    func makeUIViewController(context: Context) -> AuthenticatePlayer {
        return AuthenticatePlayer()
    }

    func updateUIViewController(_ uiViewController: AuthenticatePlayer, context: Context) {

    }
}
