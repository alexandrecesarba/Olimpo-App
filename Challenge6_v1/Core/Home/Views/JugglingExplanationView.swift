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
    var image:String {challenge.image }
    var color:Color {challenge.color}
    var shadowColor: Color {challenge.shadowColor}
    var opacity:Double {challenge.opacity}

    @State var startOffsetY: CGFloat = screenHeight * 0.90
    @State var endOffsetY: CGFloat = 0.0
    @State var currentDragOffsetY: CGFloat = 0.0


    var body: some View {

        if !returnScreen {
            ZStack{
                PlayerView()
                draggableExerciseView

            }.ignoresSafeArea(edges: .bottom)
        }

        else{
            ContentView()
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

            uponDivider

            underDivider

            Spacer() // deixar para finalizar a View


        }
        .padding(.top, 40)

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

            Image("Medal")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth/2.25, height: screenHeight/2.25)
                .padding(.leading, -150)
                .padding(.vertical, -60)
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
                        .foregroundColor(Color.theme.primary)
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
        }
        .padding()
        .padding(.horizontal, 15)

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
