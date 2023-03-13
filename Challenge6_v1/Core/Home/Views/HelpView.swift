//
//  HelpView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 08/03/23.
//

import SwiftUI
import AVKit
import AVFoundation

struct HelpView: View {
    @Binding var challenge:Challenge
    @State private var returnScreen: Bool = false
    @State var startOffsetY: CGFloat = screenHeight * 0.90
    @State var endOffsetY: CGFloat = 0.0
    @State var currentDragOffsetY: CGFloat = 0.0
    @State var blurView: Bool = false

    var body: some View {

        if !returnScreen {

            ZStack{


                PlayerView()
                if blurView {
                    Rectangle()
                        .frame(width: screenWidth, height: screenHeight)
                        .opacity(0.6)
                    
                }

                chevronUp
                draggableExerciseView
                buttons

            }
            .ignoresSafeArea()
        }

        else {
            JugglingExplanationView(challenge: $challenge)
        }
    }

    var draggableExerciseView: some View {
        exerciseView
            .offset(y: startOffsetY)
            .offset(y: currentDragOffsetY)
            .offset(y: endOffsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation(.spring()){
                            currentDragOffsetY = value.translation.height
                        }
                    })

                    .onEnded({ value in
                        withAnimation(.spring()){
                            if currentDragOffsetY < -150{
                                endOffsetY = -startOffsetY + 200
                                currentDragOffsetY = 0
                            }
                            else if currentDragOffsetY > 150 && endOffsetY != 0 {
                                endOffsetY = 0
                                currentDragOffsetY = 0
                            }
                            else{
                                currentDragOffsetY = 0

                            }

                        }

                        blurView.toggle()
                        LoopingPlayerUIView(frame: .zero).pauseVideo()



                    }))

    }

    var chevronUp: some View{
        VStack{
            Spacer()

                Image(systemName: "chevron.compact.up")
                    .resizable()
                    .frame(width: 44, height: 12.57)
                    .foregroundColor(Color.theme.gray)



        }
        .padding(.vertical, 110)
    }

    var exerciseView:some View{
        VStack(spacing: 20){
            //                RoundedRectangle(cornerRadius: 6)
            Text("Learn More")
                .foregroundColor(Color.theme.gray)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 20)


            Spacer() // deixar para finalizar a View


        }
        .padding(.bottom, 100)
        .frame(maxWidth: .infinity, idealHeight: screenHeight)
        .background(Color(hex:0x212529))
        .cornerRadius(34)
    }

    var buttons: some View {

        VStack{
            HStack {
                Button {
                    withAnimation {
                        self.returnScreen.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30, alignment: .center)
                        .contentShape(Rectangle())
                }
                Spacer()

            }
            Spacer()
        }
        .padding(.top, 65)
        .padding(.leading, 20)

    }
    



    
}



struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView(challenge: .constant(Challenge(title: "Keep-Ups",
                                                subTitle: "Soccer/Football",
                                                description: "Test your ball skills as you use your feet to juggle the ball. Be careful to not let it touch the ground", image: "juggling",
                                                color: Color.theme.greenCard,
                                                shadowColor: Color.theme.primary,
                                                opacity: 1.0)))    }
}


