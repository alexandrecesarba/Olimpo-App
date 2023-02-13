//
//  JugglingExplanationView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//

import SwiftUI
import AVKit
import AVFoundation

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height



struct JugglingExplanationView: View {
    @State var returnScreen: Bool = false
    @Binding var challenge:Challenge
    var title:String {challenge.title}
    var subtitle:String {challenge.subTitle}
    var description:String {challenge.description}
    var image:String {challenge.image}
    var color:Color {challenge.color}
    var shadowColor: Color {challenge.shadowColor}
    var opacity:Double {challenge.opacity}

    @State var startOffsetY: CGFloat = screenHeight * 0.90
    @State var endOffsetY: CGFloat = 0.0
    @State var currentDragOffsetY: CGFloat = 0.0
    @State var openCamera:Bool = false
    @State private var isLoading: Bool = true


    @EnvironmentObject var notifier: EventMessenger

    var body: some View {

        if !returnScreen && !openCamera {
            ZStack{
                


                if isLoading{
                    ZStack{
                        Color.theme.background
                        LoadingView()
//                        backButton
//                            .padding(.top, 100)


                        draggableExerciseView
                    }
                }

                else {
                    PlayerView()

                    backButton
                        .padding(.top, 100)

                    draggableExerciseView

                }

            }     .onAppear{
                startLoading()
            }

            .ignoresSafeArea(edges: .bottom)
        }



        else{
            if openCamera{
                CurrentExerciseView()
            }

            else {
                ContentView()

            }
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
                    }))

    }

    var exerciseView:some View{
        VStack(spacing: 20){
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 100, height: 4)
                .foregroundColor(Color.theme.gray)
                .padding(.top, 20)


            uponDivider

            underDivider

            Spacer() // deixar para finalizar a View


        }
        .padding(.bottom, 450)

        .frame(maxWidth: .infinity, idealHeight: screenHeight)
        //                .shadow(color: challenge.shadowColor, radius: 20, x: 0, y: -4)
        .background(LinearGradient(gradient: Gradient(stops: [.init(color: challenge.color.opacity(0.6), location: 0.00), .init(color: Color.black, location: 0.40)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(34)
    }

    var underDivider: some View {
        VStack{
            RoundedRectangle(cornerRadius: 0)
                .frame(width: screenWidth - 60, height: 2)
                .foregroundColor(Color.theme.gray.opacity(0.3))

            Text(challenge.description)
                .foregroundColor(Color.theme.gray)
                .multilineTextAlignment(.leading)
                .frame(width: 334, height: 70)
                .italic()
                .fontWeight(.light)
                .padding(.vertical, 20)
                .padding(.leading, -20)

            

            HStack(spacing: 20) {
                Image("Medal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth/2.00, height: screenHeight/2.00)
                    .padding(.vertical, -60)
                    .padding(.top, 50)
                    .overlay {
                            Text("\(EventMessenger.shared.highScore)")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.theme.blackButton)
                            .padding(.bottom, 10)
                    }

                VStack(spacing: 20){
                    Text("Best Score:")
                        .fontWeight(.regular) +
                    Text("\(EventMessenger.shared.highScore)")
                        .fontWeight(.heavy)
                    Text("Last Score: ")
                        .fontWeight(.regular) +
                    Text("\(EventMessenger.shared.lastScore)")
                        .fontWeight(.heavy)

                }
                .font(.title3)
                .foregroundColor(Color.theme.gray)


            }
            .padding(.vertical, -50)
        }

    }


    var backButton: some View {

        VStack{
            HStack {
                Button {
                    withAnimation {
                        self.returnScreen.toggle()
                    }
                } label: {

                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.theme.blackButton)
                        .frame(width: screenWidth/14)
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.top, 65)
        .padding(.leading, 20)
    }

    var uponDivider: some View {


        HStack{
            
            VStack{
                Text(challenge.title)
                    .foregroundColor(Color.theme.activity)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.leading, -30)
                Text(challenge.subTitle)
                    .foregroundColor(Color.theme.gray)
                    .font(.title2)
                    .fontWeight(.light)
                    .padding(.trailing)
                    .padding(.top, -20)

            }
            Spacer()

            Button {
                withAnimation(.easeOut(duration: 1)){
                    self.openCamera.toggle()
                }
            } label: {
                RoundedRectangle(cornerRadius: 30)
                  .fill(Color(red: 0.09, green: 0.78, blue: 0.39)) // essa cor só existe aqui
                  .frame(width: 81.00, height: 60.00)
                  .shadow(color: Color(red: 0.02, green: 0.53, blue: 0.40), radius: 20, x: 0, y: 0)
                  .overlay(Image(systemName: "arrowtriangle.right.fill")
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color(hex: 0xF1F3F5)))
            }
        }
        .padding()
        .padding(.horizontal, 15)

    }

    private func startLoading() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
        }
    }
}



struct JugglingExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        JugglingExplanationView(challenge: .constant(Challenge(title: "Juggling",
                                                               subTitle: "Soccer/Football",
                                                               description: "Test your ball skills as you use your feet to juggle the ball. Be careful to not let it touch the ground", image: "Illustration1",
                                                               color: Color.theme.greenCard,
                                                               shadowColor: Color.theme.primary,
                                                               opacity: 1.0)))
    }
}


struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}


class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Load the resource
        let fileUrl = Bundle.main.url(forResource: "DiogoVideo", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)

        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)

        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)

        // Start the movie
        player.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
