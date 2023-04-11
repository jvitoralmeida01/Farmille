//
//  ContentView.swift
//  Juntar com a parte de thais
//
//  Created by Rodrigo Barbosa de Oliveira on 04/04/23.
//

import SwiftUI

struct ContentView: View {
    var onImage = Image(systemName: "star.fill")
    @State var numero: Int = 1
    var body: some View {
        VStack {
            HStack{
                Text("Área").font(.title).multilineTextAlignment(.leading).padding()
                
                Spacer()
                
                Button(action: {
                    numero += 1
                }, label: {
                    Image(systemName: "questionmark.circle")
                })
            }.padding(.horizontal)
            
            Text("Desenvolvimento").padding(.vertical)
            RatingView()
            
            Text("Design").padding(.vertical)
            RatingView()
            
            Text("Inovação").padding(.vertical)
            RatingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// falta criar um array pra salvar as informações do adalberto ada
