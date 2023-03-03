//
//  WelcomeView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/02/23.
//

import SwiftUI
import GameKit
struct WelcomeView: View {
    var body: some View {
        ZStack{
            AuthenticatePlayer_Representable()
            ContentView()
            
        }
        
        
        
    }
    
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
