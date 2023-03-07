//
//  CurrentExerciseView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 01/02/23.
//

import SwiftUI

struct CurrentExerciseView: View {
    
    @State private var isLoading:Bool = false
    @Binding var isPresenting: Bool
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
                ExerciseView(isPresentedUIKit: $isPresenting)
            }
        }
        .ignoresSafeArea()
       
    }

  
    
    
    
    
    struct ExerciseView: UIViewControllerRepresentable {
        @Binding var isPresentedUIKit: Bool
        func makeUIViewController(context: Context) -> JuggleChallengeController {
            return JuggleChallengeController(isPresented: $isPresentedUIKit)
        }

        func updateUIViewController(_ uiViewController: JuggleChallengeController, context: Context) {

        }

        typealias UIViewControllerType = JuggleChallengeController


    }

}
//
//
//
//struct CurrentExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
////        CurrentExerciseView()
//    }
//}


