//
//  ChallengeView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//


import SwiftUI

struct ChallengeView: View {

    var challenge = Challenge.challengeData
    @State var showContent = false

    var body: some View {
        if !showContent {
            ScrollView {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Challenges")
                                .font(.largeTitle)

                            Text("Choose what's best for you")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.leading,40)



                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(challenge) { item in
                                Button(action: { self.showContent.toggle() }) {
                                    GeometryReader { geometry in
                                        ChallengeScroll(title: item.title,
                                                        subtitle: item.subTitle,
                                                        image: item.image,
                                                        color: item.color,
                                                        shadowColor: item.shadowColor)
                                        .rotation3DEffect(Angle(degrees:
                                                                    Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))

                                    }
                                    .frame(width: 246, height: 360)
                                }
                            }
                        }
                        .padding(.leading, 30)
                        .padding(.top, 100)
                        .padding(.bottom, 70)
                        Spacer()
                    }
                }
                .padding(.top, 30)
            }
        }
        else {
            JugglingExplanationView()
        }
    }
}

#if DEBUG
struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
#endif

struct ChallengeScroll: View {

    var title = "Juggling"
    var subtitle = "Soccer/Football"
    var image = "Illustration1"
    var color = Color.theme.green
    var shadowColor = Color("backgroundShadow3")

    var body: some View {
        VStack(alignment: .leading) {
            Image(image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 246, height: 150)
                .padding(.bottom, 30)

            Spacer()

            VStack{
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.activity)
                Text(subtitle)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(Color.theme.description)
            }
            .padding(30)

        }
        .background(color)
        .cornerRadius(30)
        .frame(width: 246, height: 360)
        .shadow(color: shadowColor.opacity(0.4), radius: 20, x: 0, y: 20)

    }
}


