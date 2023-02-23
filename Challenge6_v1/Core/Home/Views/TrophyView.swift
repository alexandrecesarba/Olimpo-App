//
//  TrophyView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//

import SwiftUI


struct TrophyView: View {

    @State private var vipAchievement = VipAchievement.all
    @State private var completed = false
//    let filtered = EventMessenger.shared.scoreArray.prefix(10).filter { score in
//        return score <= 10
//    }
    var body: some View {

        ZStack {
            Color.theme.background

            VStack{
                selectedActivity

                achievements

                Spacer()
            }
            .padding(.top, 80)
        }
        .ignoresSafeArea()
    }


    var selectedActivity: some View {
        HStack{
            // MARK: Ajeitar para todas as atividades, não apenas juggling
            VStack{
                Text("Juggling")
                    .font(.title)
                    .foregroundColor(.primary)
                    .fontWeight(.regular)
                    .italic()
                Text("Soccer / Football")
                    .foregroundColor(Color.theme.gray)
                    .fontWeight(.light)
                    .padding(.trailing, -20)

            }
            Spacer()
        }
        .padding(.horizontal, 20)

    }

    var achievements: some View {
        HStack{
            ForEach((vipAchievement)) {
                item in
                VStack{
                        Image(item.badge)
                            .resizable()
                            .scaledToFit()
                            .overlay {
                                Text("\(item.goal)")
                                    .padding()
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                }
                    Text(item.name)
                }
                .opacity(item.completed ? 1.0 : 0.2)

                .padding()


            }
        }

    }
}

struct TrophyView_Previews: PreviewProvider {
    static var previews: some View {
        TrophyView()
    }
}
