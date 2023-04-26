//
//  SkillMappingView.swift
//  Farmille
//
//  View principal do skillmapping
//
//  Created by Thaís Vasconcelos Couto on 04/04/23.
//
import SwiftUI

struct SkillMappingView: View {
    @EnvironmentObject private var database: Database
    
    @State var showHelp = false
    
    @State var devRating = 1
    @State var designRating = 1
    @State var innovationRating = 1
    
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
                        .font(.system(size: 25))

                    Spacer()
                    
                    Button(action: {
                        showHelp = true
                    }, label: {
                        Image(systemName: "questionmark.circle").font(.system(size: 25))
                    })


                }
                .padding(.horizontal)

                Text("Desenvolvimento:")
                    .font(.system(size: 25))
                    .padding()

                RatingView(rating: $devRating)

                Text("Design:")
                    .font(.system(size: 25))
                    .padding()

                RatingView(rating: $designRating)

                Text("Inovação:")
                    .font(.system(size: 25))
                    .padding()

                RatingView(rating: $innovationRating)

            }
            .padding(.bottom, 100)

            
            
            NavigationLink(destination: ProjectView()) {
                Text("Concluir Cadastro")
            }.simultaneousGesture(TapGesture().onEnded{
                saveUserSkillMap()
            })

        }
        
        .sheet(isPresented: $showHelp) {
            SkillmappingHelpView()
        }

    }
    func saveUserSkillMap() {
        let ratingToSave = Rating(dev: devRating, design: designRating, innovation: innovationRating)
        self.database.saveUserRating(rating: ratingToSave)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SkillMappingView()
    }
}
