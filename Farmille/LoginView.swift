//
//  Login.swift
//  TesteFoundations
//
//  Created by Vinicius Torres de Macedo on 28/03/23.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var title: String = ""
    var body: some View {
        VStack {
            Image("LoginMemojis")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
            TextField("Explore Farmille!", text: $title)
                .padding(.horizontal, 30)
                .bold()
                .padding(.vertical)
                .font(.system(size: 20))
            Button("Create project", action: createProject)
            .buttonStyle(.borderedProminent)
            Button("Not now", action: back)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
            .background(LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .top, endPoint: .bottom))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
