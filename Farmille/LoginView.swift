//
//  Login.swift
//  TesteFoundations
//
//  Created by Vinicius Torres de Macedo on 28/03/23.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct CardView: View{
    var body: some View{
        VStack{
            Text("Explore Farmille!")
                .padding(.horizontal, 30)
                .padding(.vertical, 5)
                .foregroundColor(.white)
                .bold()
                .frame(alignment: .center)
                .font(.system(size: 30))
            Text("Gerencie sua equipe de uma forma rápida e intuitita. Crie tarefas e fique por dentro de todo o andamento do seu projeto.")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 5)
        }
        
    }
}


struct LoginView: View {
    @State private var title: String = ""
    @State private var index = 0
    
    var body: some View {
        VStack {
            Image("LoginMemojis")
                .resizable()
                .aspectRatio(contentMode: .fit)
            TabView(selection: $index) {
                ForEach((0..<3), id: \.self) {index in
                    CardView()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(height: 200)
            Image("LoginButtonApple")
                .frame(alignment: .center)
            Image("LoginButtonGoogle")
                .frame(alignment: .center)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
            .background(LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .top, endPoint: .bottom))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
