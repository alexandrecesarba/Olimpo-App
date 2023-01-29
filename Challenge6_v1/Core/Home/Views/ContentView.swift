//
//  ContentView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//

import SwiftUI

struct ContentView: View {

//    @Binding var showContent: Bool

    var body: some View {

        ZStack{
            VStack{
                ChallengeView()
                Spacer()
                TabBar()
                    .padding()
            }
        }


    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif


enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    case trophy, challenges, person

    internal var id: Int { rawValue }

    var icon: String {
        switch self {
        case .trophy:
            return "trophy.fill"
        case .challenges:
            return "circle.hexagongrid"
        case .person:
            return "person.fill"

        }
    }

    var title: String {
        switch self {
        case .trophy:
            return "Trophy"
        case .challenges:
            return "Challenges"
        case .person:
            return "Person"

        }
    }

    var color: Color {
        switch self {
        case .trophy:
            return Color.theme.green
        case .challenges:
            return Color.theme.green
        case .person:
            return Color.theme.green
        }
    }

    var view: any View{
        switch self {
        case .trophy:
            return TrophyView()
        case .challenges:
            return ChallengeView()
        case .person:
            return PersonView()
        }
    }
}
