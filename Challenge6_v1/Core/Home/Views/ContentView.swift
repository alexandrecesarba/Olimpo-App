//
//  ContentView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//

import SwiftUI

struct ContentView: View {

//    @Binding var showContent: Bool
    @State var selectedTab: Tab = .challenges
    @State var showContent:Bool = false

    var body: some View {

        ZStack{
            Color.theme.background
            VStack{
                if selectedTab == .challenges{
                    ChallengeView(showContent: $showContent)
                }
                if selectedTab == .trophy {
                    TrophyView()
                }
                if selectedTab == .person {
                    PersonView()
                }
                Spacer()

                if !showContent{
                    TabBar(selectedTab: $selectedTab)
                        .padding(.bottom, 50)
                }
            }
        }.ignoresSafeArea()


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
            return "Achievements"
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


}
