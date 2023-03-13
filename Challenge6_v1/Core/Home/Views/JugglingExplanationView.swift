//
//  JugglingExplanationView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//

import SwiftUI


let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height



struct JugglingExplanationView: View {


    @Binding var challenge:Challenge
    var title:String {challenge.title}
    var subtitle:String {challenge.subTitle}
    var description:String {challenge.description}
    var image:String {challenge.image}
    var color:Color {challenge.color}
    var shadowColor: Color {challenge.shadowColor}
    var opacity:Double {challenge.opacity}


    @State var openCamera:Bool = false
    @State private var isLoading: Bool = true
    @State var returnScreen: Bool = false
    @State var helpView: Bool = false


    @EnvironmentObject var notifier: EventMessenger

    var body: some View {
        
        ZStack{
            if !returnScreen && !openCamera && !helpView {
                ZStack{

                    // Background image
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth/1.3)
                        .padding(.bottom, 100)
                        .opacity(0.1)

                    VStack(spacing: 30){
                        titleAndSubtitle

                        // Divider
                        RoundedRectangle(cornerRadius: 0)
                            .frame(width: screenWidth - 60, height: 2)
                            .foregroundColor(Color.theme.gray.opacity(0.3))

                        // Description
                        Text(description)
                            .foregroundColor(Color.theme.activity)
                            .multilineTextAlignment(.center)
                            .fontWeight(.thin)
                            .italic()

                        medalAndRecord



                    }
                    .foregroundColor(Color.theme.activity)
                    .padding()
                    .padding(.bottom, 150)
                    playButton

                    buttons
                        .padding(.bottom, 150)

                    
                }
                .background(LinearGradient(gradient: Gradient(stops: [.init(color: challenge.color.opacity(1.0), location: 0.00), .init(color: Color.black, location: 2.00)]), startPoint: .top, endPoint: .bottom))
                
                .ignoresSafeArea(edges: .bottom)
                .animation(.easeInOut, value: isLoading)
                
            }

            else {
                if openCamera{
                    CurrentExerciseView(isPresenting: $openCamera)
                }
                else if helpView{
                    HelpView(challenge: $challenge)
                }
                else {
                    ContentView()
                }
            }
        }.animation(.easeInOut, value: openCamera)
    }

    // MARK: Views

    var titleAndSubtitle: some View {
        VStack(spacing: 10){

            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(subtitle)
                .font(.title2)
                .fontWeight(.thin)
        }

        
    }

    var medalAndRecord: some View {
        HStack(spacing: 20) {
            Image("medalNew")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth/2.50, height: screenHeight/2.50)
                .padding(.vertical, -60)
                .padding(.top, 50)
                .overlay {
                    Text("\(EventMessenger.shared.highScore)")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.blackButton)

                }

            VStack(spacing: 20){
                Text("Best Score: ")
                    .fontWeight(.regular) +
                Text("\(EventMessenger.shared.highScore)")
                    .fontWeight(.heavy)
                Text("Last Score: ")
                    .fontWeight(.regular) +
                Text("\(EventMessenger.shared.lastScore)")
                    .fontWeight(.heavy)

            }
            .font(.title3)
            .foregroundColor(Color.theme.activity)


        }
    }

    //    var draggableExerciseView: some View {
    //        exerciseView
    //            .offset(y: startOffsetY)
    //            .offset(y: currentDragOffsetY)
    //            .offset(y: endOffsetY)
    //            .gesture(
    //                DragGesture()
    //                    .onChanged({ value in
    //                        withAnimation(.spring()){
    //                            currentDragOffsetY = value.translation.height
    //                        }
    //                    })
    //
    //                    .onEnded({ value in
    //                        withAnimation(.spring()){
    //                            if currentDragOffsetY < -150{
    //                                endOffsetY = -startOffsetY + 200
    //                                currentDragOffsetY = 0
    //                            }
    //                            else if currentDragOffsetY > 150 && endOffsetY != 0 {
    //                                endOffsetY = 0
    //                                currentDragOffsetY = 0
    //                            }
    //                            else{
    //                                currentDragOffsetY = 0
    //
    //                            }
    //                        }
    //                    }))
    //
    //    }
    //
    //    var exerciseView:some View{
    //        VStack(spacing: 20){
    //            RoundedRectangle(cornerRadius: 6)
    //                .frame(width: 100, height: 4)
    //                .foregroundColor(Color.theme.gray)
    //                .padding(.top, 20)
    //
    //
    //            uponDivider
    //
    //            underDivider
    //
    //            Spacer() // deixar para finalizar a View
    //
    //
    //        }
    //        .padding(.bottom, 450)
    //
    //        .frame(maxWidth: .infinity, idealHeight: screenHeight)
    //        //                .shadow(color: challenge.shadowColor, radius: 20, x: 0, y: -4)
    //        .background(LinearGradient(gradient: Gradient(stops: [.init(color: challenge.color.opacity(0.6), location: 0.00), .init(color: Color.black, location: 0.40)]), startPoint: .top, endPoint: .bottom))
    //        .cornerRadius(34)
    //    }
    //
    //    var underDivider: some View {
    //        VStack{
    //            RoundedRectangle(cornerRadius: 0)
    //                .frame(width: screenWidth - 60, height: 2)
    //                .foregroundColor(Color.theme.gray.opacity(0.3))
    //
    //            Text(challenge.description)
    //                .foregroundColor(Color.theme.gray)
    //                .multilineTextAlignment(.leading)
    //                .frame(width: 334, height: 70)
    //                .italic()
    //                .fontWeight(.light)
    //                .padding(.vertical, 20)
    //                .padding(.leading, -20)
    //
    //
    //
    //            HStack(spacing: 20) {
    //                Image("Medal")
    //                    .resizable()
    //                    .scaledToFit()
    //                    .frame(width: screenWidth/2.00, height: screenHeight/2.00)
    //                    .padding(.vertical, -60)
    //                    .padding(.top, 50)
    //                    .overlay {
    //                            Text("\(EventMessenger.shared.highScore)")
    //                            .font(.title)
    //                            .fontWeight(.heavy)
    //                            .foregroundColor(Color.theme.blackButton)
    //                            .padding(.bottom, 10)
    //                    }
    //
    //                VStack(spacing: 20){
    //                    Text("Best Score: ")
    //                        .fontWeight(.regular) +
    //                    Text("\(EventMessenger.shared.highScore)")
    //                        .fontWeight(.heavy)
    //                    Text("Last Score: ")
    //                        .fontWeight(.regular) +
    //                    Text("\(EventMessenger.shared.lastScore)")
    //                        .fontWeight(.heavy)
    //
    //                }
    //                .font(.title3)
    //                .foregroundColor(Color.theme.gray)
    //
    //
    //            }
    //            .padding(.vertical, -50)
    //        }
    //
    //    }

    var playButton: some View{
        Button {
            withAnimation(.easeOut(duration: 1)){
                self.openCamera.toggle()
            }
        } label: {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(red: 0.09, green: 0.78, blue: 0.39)) // essa cor só existe aqui
                .frame(width: 100.0, height: 70.0)
                .shadow(color: Color(red: 0.02, green: 0.53, blue: 0.40), radius: 20, x: 0, y: 0)
                .overlay(Image(systemName: "arrowtriangle.right.fill")
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color(hex: 0xF1F3F5)))
        }
        .padding(.top, 500)

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


                Button {
                    withAnimation {
                        self.helpView.toggle()
                    }
                } label: {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30, alignment: .center)
                        .contentShape(Rectangle())
                        .padding()
                }
            }
            Spacer()
        }
        .padding(.top, 65)
        .padding(.leading, 20)

    }



}



struct JugglingExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        JugglingExplanationView(challenge: .constant(Challenge(title: "Keep-Ups",
                                                               subTitle: "Soccer/Football",
                                                               description: "Test your ball skills as you use your feet to juggle the ball. Be careful to not let it touch the ground", image: "juggling",
                                                               color: Color.theme.greenCard,
                                                               shadowColor: Color.theme.primary,
                                                               opacity: 1.0)))
    }
}


