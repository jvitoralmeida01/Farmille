//
//  SkillMappingView.swift
//  Farmille
//
//  Created by Thaís Vasconcelos Couto on 04/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    
        VStack {
            
            Image("adalberto")
            
                .resizable()

                .aspectRatio(contentMode: .fit)

                .frame(width: 100, height: 100)
            
            
            Text("Adalberto Ada")
            
                .bold()
            
                .font(.system(size: 30))
            
            Text("adalbertoada@cin.ufpe.br")
            
                .font(.system(size: 12))
            
            VStack {
                
                HStack{
                    Text("Áreas de conhecimento:")
                    
                        .bold()
                    
                        .padding(.vertical)
                    
                        .font(.system(size: 25))
                    
                    Spacer()
                    
                    Button(action: {
                        // navegação pra tela skillmappingHelpView
                        
                    }, label: {
                        Image(systemName: "questionmark.circle").font(.system(size: 25))
                    })
                    
                    
                }
                .padding(.horizontal)
                
                Text("Desenvolvimento:")
                    .font(.system(size: 25))
                    .padding()
                
                RatingView()
                
                Text("Design:")
                    .font(.system(size: 25))
                    .padding()
                
                RatingView()
                
                Text("Inovação:")
                    .font(.system(size: 25))
                    .padding()
                
                RatingView()
                
            }
            .padding(.bottom, 100)
            
            Button("Concluir cadastro", action: {
                
            })
            
                .buttonStyle(.borderedProminent)
            
            Button("Agora não", action: {
                
            })
            
        }
        
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
