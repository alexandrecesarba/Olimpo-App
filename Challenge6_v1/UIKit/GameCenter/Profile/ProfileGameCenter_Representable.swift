//
//  ProfileGameCenter_Representable.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/02/23.
//

import Foundation
import SwiftUI

struct ProfileGameCenter_Representable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ProfileGameCenter

    func makeUIViewController(context: Context) -> ProfileGameCenter {
        return ProfileGameCenter()
    }

    func updateUIViewController(_ uiViewController: ProfileGameCenter, context: Context) {

    }
}


