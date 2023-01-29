//
//  Challenge.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//

import Foundation
import SwiftUI

struct Challenge: Identifiable {

    static let challengeData = [
        Challenge(title: "Juggling",
                  subTitle: "Soccer/Football",
                  image: "Illustration1", // inserir
                  color: Color.theme.green,
                  shadowColor: Color.theme.primary),
        Challenge(title: "Crossbar",
                  subTitle: "Soccer/Football",
                  image: "Illustration2",
                  color: Color(.brown),
                  shadowColor: Color.theme.primary)
    ]

    var id = UUID()
    var title: String
    var subTitle: String
    var image: String
    var color: Color
    var shadowColor: Color
}

