//
//  Achievements.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 14/02/23.
//

import Foundation


class VipAchievement: Identifiable{



    static var firstLine = [VipAchievement(name: "NOVATO", badge: "stamp", goal: 5, completed: false), VipAchievement(name: "VALENTE", badge: "stamp", goal: 10, completed: false), VipAchievement(name: "CRAQUE", badge: "stamp", goal: 25, completed: false)]

    static var secondLine = [VipAchievement(name: "FENÔMENO", badge: "stamp", goal: 50, completed: false), VipAchievement(name: "REI", badge: "stamp", goal: 100, completed: false)]

    var id = UUID()
    var name: String
    var badge: String // imageName
    var goal: Int
    var completed: Bool


    init(name: String, badge: String, goal: Int, completed: Bool) {
        self.name = name
        self.badge = badge
        self.goal = goal
        self.completed = completed
    }

    public func checkCompletion(scores:[Int]) -> Bool {
        self.completed = false
        for score in scores {
            if score >= goal{
                self.completed = true
            }
            
        }
        return self.completed
    }


}
