//
//  TrophyView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//

import SwiftUI


struct TrophyView: View {

    @State private var firstLineAchievement = VipAchievement.firstLine

    @State private var secondLineAchievement = VipAchievement.secondLine

    @State private var completed = false


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
        VStack{
            firstLineAchievementView
            secondLineAchievementView
        }.aspectRatio(1, contentMode:.fit)

    }


    var firstLineAchievementView: some View {
        HStack{
            ForEach(firstLineAchievement) {
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
                            .shadow(color: Color.theme.green, radius: 10)
                    Text(item.name)
                        .foregroundColor(Color.theme.gray)
                        .fontWeight(.heavy)
                }
                .opacity(item.checkCompletion(scores: EventMessenger.shared.scoreArray) ? 1.0 : 0.2)
                .padding()


            }
        }
    }

    var secondLineAchievementView: some View {
        HStack{
            ForEach(secondLineAchievement) {
                item in 
                VStack{
                        Image(item.badge)
                            .scaledToFit()
                            .overlay {
                                Text("\(item.goal)")
                                    .padding()
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                }
                            .shadow(color: Color.theme.green, radius: 10)
                    Text(item.name)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.gray)
                }
                .opacity(item.checkCompletion(scores: EventMessenger.shared.scoreArray) ? 1.0 : 0.2)
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
