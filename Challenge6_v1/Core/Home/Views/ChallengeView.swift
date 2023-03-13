//
//  ChallengeView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//


import SwiftUI

struct ChallengeView: View {

    @State var challenge = Challenge.challengeData
    @Binding var showContent: Bool
    @EnvironmentObject var notifier: EventMessenger
    @State private var showingAlert = false


    var body: some View {
        if !showContent {
            ScrollView {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Challenges")
                                .font(.largeTitle)
                                .fontWeight(.semibold)

                            Text("Choose what's best for you")
                                .font(.title3)
                                .foregroundColor(Color.theme.gray)
                                .fontWeight(.medium)
                                .padding(.top, -20)

                        }
                        Spacer()
                    }
                    .padding(.leading,40)
                    .padding(.top, 50)



                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(challenge) { item in
                                Button(action: {
                                    withAnimation(.linear(duration: 0.5)) {

                                        if item.opacity == 1{
                                            self.showContent.toggle()
                                        }

                                        else{
                                            self.showingAlert.toggle()
                                        }


                                    }
                                }) {
                                    GeometryReader { geometry in
                                        ChallengeScroll(title: item.title,
                                                        subtitle: item.subTitle,
                                                        image: item.image,
                                                        color: item.color,
                                                        shadowColor: item.shadowColor)
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 50 ) / 10)
                                                , axis: (x: 0, y: -30, z: 0))
                                        .opacity(item.opacity)


                                    }
                                    .frame(width: 246, height: 425)
                                }
                            }
                        }
//                        .padding(.leading, 30)
                        .padding([.leading,.trailing], 40)
                        .padding(.top, 100)
                        .padding(.bottom, 70)
                        Spacer()
                    }
                }
                .alert("Coming soon!", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {}
                }
                .padding(.top, 30)
            }
        }
        else {
            // TODO: especificar as views
            ForEach(challenge) { item in
                if item.opacity == 1{
                    JugglingExplanationView(challenge: $challenge[0])
        
                }


            }
//                .transition(.scale)
        }
    }
}

#if DEBUG
struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView(showContent: .constant(false))
    }
}
#endif

struct ChallengeScroll: View {

    var title = "Keep-Ups"
    var subtitle = "Soccer/Football"
    var image = "Illustration1"
    var color = Color.theme.green
    var shadowColor = Color("backgroundShadow3")
    var opacity = 0.0

    var body: some View {

        ZStack{
        VStack(alignment: .leading) {
            Image(image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .padding(.top, 50)
                .frame(width: 246, height: 300)

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
        .shadow(color: shadowColor.opacity(0.4), radius: 15, x: 0, y: 0)

    }
}
}


