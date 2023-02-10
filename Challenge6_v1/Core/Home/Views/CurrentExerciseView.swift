//
//  CurrentExerciseView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 01/02/23.
//

import SwiftUI

struct CurrentExerciseView: View {
    
    @State private var isLoading:Bool = true
    // Solution: Observable Object sent to UIKit
    // With that, we can use the same value in both frameworks (UIKit and SwiftUI)
    var body: some View {
        ZStack{

            if isLoading{
                ZStack{
                    Color.theme.background
                    LoadingView()
                }
            }

            else {
                ExerciseView()
            }
        }
        .onAppear{startLoading()}
        .ignoresSafeArea()
    }

    private func startLoading() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            isLoading = false
        }
    }

}



struct CurrentExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentExerciseView()
    }
}

struct ExerciseView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> JuggleChallengeController {
        return JuggleChallengeController()
    }

    func updateUIViewController(_ uiViewController: JuggleChallengeController, context: Context) {

    }

    typealias UIViewControllerType = JuggleChallengeController


}

