//
//  Challenge6_v1App.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//

import SwiftUI

@main
struct Challenge6_v1App: App {
    @StateObject var selectedTab = CurrentTab()
    @StateObject var notifier = EventMessenger()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(selectedTab)
                .environmentObject(self.notifier)
        }
    }
}
