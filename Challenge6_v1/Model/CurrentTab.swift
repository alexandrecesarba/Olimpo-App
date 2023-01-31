//
//  Menu.swift
//  Handle v.AgoraVai
//
//  Created by Alexandre César Brandão de Andrade on 31/10/22.
//

import Foundation

class CurrentTab:ObservableObject{

    @Published var selectedTab:Tab


    init(){
        self.selectedTab = .challenges
    }
}
