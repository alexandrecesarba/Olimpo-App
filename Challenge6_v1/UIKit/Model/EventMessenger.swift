//
//  EventMessenger.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 10/02/23.
//

import Foundation

class EventMessenger: ObservableObject {

    // Singleton
    public static var shared: EventMessenger = EventMessenger()

    /// Amount of points accumulated aka Last Score
    @Published var pointsCounted: Int = 0

    /// User High Score
    public var highScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: "highScore")
        }

        set{
            UserDefaults.standard.set(newValue, forKey: "highScore")
        }
    }

    /// Increases the number of points
    public func addScore(){
        self.pointsCounted += 1
    }

    /// Locally stores the high score
    public func saveHighScore(){
        if self.pointsCounted > self.highScore{
            self.highScore = self.pointsCounted
        }
    }
}
