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
                  subTitle: "Soccer / Football",
                  description: "Test your ball skills as you use your feet to juggle the ball. Be careful to not let it touch the ground!", image: "Illustration1",
                  color: Color.theme.greenCard,
                  shadowColor: Color.theme.primary,
                  opacity: 1.0),
        Challenge(title: "Crossbar",
                  subTitle: "Soccer/Football",
                  description: "None",
                  image: "Illustration2",
                  color: Color(.brown),
                  shadowColor: Color.theme.primary,
                  opacity: 0.4),
//        Challenge(title: "Ghost",
//                  subTitle: "Soccer/Football",
//                  image: "Illustration2",
//                  color: Color(.brown),
//                  shadowColor: Color.theme.primary,
//                  opacity: 0.0)
    ]

    var id = UUID()
    var title: String
    var subTitle: String
    var description: String
    var image: String
    var color: Color
    var shadowColor: Color
    var opacity: Double 
}

