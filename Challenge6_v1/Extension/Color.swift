//
//  Color.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//


import SwiftUI
import Foundation

// TODO: Colocar as cores da paleta
extension Color {

    //  podemos acessar todas as cores abaixo
    static let theme = ColorTheme()

    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct ColorTheme {

    let primary = Color("Primary")
    let background = Color("Background")
    let green = Color("Green")
    let greenCard = Color("GreenCard")
    let gray = Color("Gray")
    /// Juggling, crossbar...
    let activity = Color("Activity")
    /// Soccer/football
    let description = Color("Description")
    let blackButton = Color("BlackButton")
    

}


