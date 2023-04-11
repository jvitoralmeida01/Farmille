//
//  SkillMappingView.swift
//  Farmille
//
//  Created by Thaís Vasconcelos Couto on 04/04/23.
//

import SwiftUI

struct SkillMappingView: View {
    @Binding var rating: Int
    var label = ""
    var maximumRating = 5
    var starOn = Image(systemName: "star.fill")
    var starOff = Image(systemName: "star")
    var colorOff = Color.gray
    var colorOn = Color.yellow
    
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
                
                HStack{
                    if label.isEmpty == false{
                        Text(label)
                    }
                    ForEach(1..<maximumRating+1, id: \.self){ number in
                        image(for: number)
                            .foregroundColor(number > rating ? colorOff : colorOn)
                            .onTapGesture {
                                rating = number
                            }
                        
                    }
                }
                
                Text("Design:")
                
                    .font(.system(size: 16))
                
                HStack{
                    if label.isEmpty == false{
                        Text(label)
                    }
                    ForEach(1..<maximumRating+1, id: \.self){ number in
                        image(for: number)
                            .foregroundColor(number > rating ? colorOff : colorOn)
                            .onTapGesture {
                                rating = number
                            }
                        
                    }
                }
                
                Text("Inovação:")
                
                    .font(.system(size: 16))
                
                HStack{
                    if label.isEmpty == false{
                        Text(label)
                    }
                    ForEach(1..<maximumRating+1, id: \.self){ number in
                        image(for: number)
                            .foregroundColor(number > rating ? colorOff : colorOn)
                            .onTapGesture {
                                rating = number
                            }
                        
                    }
                }
                
            }
            
            .padding(.leading)
            
            .padding(.bottom, 250)
            
            
            Button("Concluir cadastro", action: createProject)
            
                .buttonStyle(.borderedProminent)
            
            Button("Agora não", action: back)
            
        }
        
    }
    
    func image (for number: Int) -> Image{
        if number > rating{
            return starOff
        } else {
            return starOn
        }
    }

}


struct SkillMappingView_Previews: PreviewProvider {
    static var previews: some View {
        SkillMappingView(rating: .constant(4))
    }
}
