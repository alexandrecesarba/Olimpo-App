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
}


struct ColorTheme {

    let primary = Color("Primary")
    let background = Color("BackgroundColor")
    let green = Color("Green")
    let activity = Color("Activity") // juggling, crossbar...
    let description = Color("Description") // soccer/football

}


