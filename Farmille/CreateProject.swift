//
//  CreateProject.swift
//  Farmille
//
//  Created by Joao Almeida on 30/03/23.
//

import SwiftUI

struct CreateProject: View {
    @State var showModal = false

    @State private var title: String = ""
    @State private var selectedTab = 0

    var body: some View {

        VStack {

            Text("Novo Projeto")
                .bold()
                .padding()
                .font(.system(size: 30))
            
            Image("Island")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)

            TextField("Insira o nome do projeto", text: $title)
                .padding(.horizontal, 30)
                .padding(.vertical, 30)

            HStack {
                Text("Membros")
                    .bold()
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button("Add more +", action: openAddMembersModal)
            }
            .padding(.horizontal, 30)

            HStack (spacing: -25) {
                Image("ProfilePic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .zIndex(3)

                Image("ProfilePic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .zIndex(2)

                Image("ProfilePic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .zIndex(1)

                Spacer()
            }
            .padding(.leading, 25)
            .padding(.bottom, 150)

            Button("Criar projeto", action: createProject)

            .buttonStyle(.borderedProminent)

            Button("Agora não", action: back)

        }
        .sheet(isPresented: $showModal) {
            ModalView()
        }
    }
    
    func openAddMembersModal() {
        showModal = true
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentation
    
    @State var currentMemberValue: String = ""
    @State var memberInputTitle: String = "E.g. Luke Skywalker"
    @State var autocompletePossibleGuesses = Constants.membersAutocomplete
    @State var autocompleteActualGuesses: Array<String> = []
    
    var body: some View {
        VStack(){
            Text("Add new members")
                .bold()
                .padding()
                .font(.system(size: 30))
            
            TextField("Insira o nome do projeto", text: $currentMemberValue)
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
            
            ForEach(searchResults, id: \.self) { guess in
                Text(guess)
            }
            
            ForEach(self.autocompleteActualGuesses, id:\.self) { guess in
                Text(guess)
            }
            
            Spacer()

            Button(action: {
                presentation.wrappedValue.dismiss()
            }, label: {
                Label("Fechar", systemImage: "xmark.circle")
            })
        }
    }
    
    var searchResults: [String] {
        if self.currentMemberValue.isEmpty {
            return []
        } else {
            let guesses = autocompletePossibleGuesses.filter { $0.lowercased().contains(currentMemberValue.lowercased())
            }
            return Array(guesses.prefix(5))
        }
    }
}


func createProject() {

    print("Hello, World!")

}



func back() {

    print("Hello, World!")

}

struct CreateProject_Previews: PreviewProvider {
    static var previews: some View {
        CreateProject()
    }
}
