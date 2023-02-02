//
//  CurrentExerciseView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 01/02/23.
//

import SwiftUI

struct CurrentExerciseView: View {
    var body: some View {
        ZStack{
            ExerciseView()
        }.ignoresSafeArea()
    }
}

struct CurrentExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentExerciseView()
    }
}

struct ExerciseView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ObjectDetectionViewController {
        return ObjectDetectionViewController()
    }

    func updateUIViewController(_ uiViewController: ObjectDetectionViewController, context: Context) {

    }

    typealias UIViewControllerType = ObjectDetectionViewController


}

