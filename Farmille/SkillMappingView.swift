//
//  SkillMappingView.swift
//  Farmille
//
//  Created by Thaís Vasconcelos Couto on 04/04/23.
//

import SwiftUI

struct SkillMappingView: View {
    var body: some View {
        
        VStack {
            
            Image("ProfilePic")
            
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
                    
                        .font(.system(size: 20))
                    
                    Image(systemName: "questionmark.circle")
                    
                }
                
                Text("Desenvolvimento:")
                
                    .font(.system(size: 16))
                
                RatingView()
                    .padding()
                
                Text("Design:")
                
                    .font(.system(size: 16))
                
                RatingView()
                    .padding()
                
                Text("Inovação:")
                
                    .font(.system(size: 16))
                
                RatingView()
                    .padding()
                
            }
            
            .padding(.leading)
            
            .padding(.bottom, 150)
            
            
            Button("Concluir cadastro", action: createProject)
            
                .buttonStyle(.borderedProminent)
            
            Button("Agora não", action: back)
            
        }
        
    }

}


struct SkillMappingView_Previews: PreviewProvider {
    static var previews: some View {
        SkillMappingView()
    }
}

