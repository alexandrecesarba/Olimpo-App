//
//  PersonView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 28/01/23.
//

import SwiftUI

struct PersonView: View {
    var body: some View {
        ZStack{
            ProfileGameCenter_Representable()
                .padding(.top, 400)
        }

    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
