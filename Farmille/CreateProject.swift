//
//  CreateProject.swift
//  Farmille
//
//  Created by Joao Almeida on 30/03/23.
//

import SwiftUI

struct CreateProject: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @EnvironmentObject private var database: Database
    
    @State var showModal = false

    @State private var title: String = ""
    @State private var selectedMembers: Array<String> = []

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
                ForEach(0..<selectedMembers.count, id: \.self) { index in
                    Image("ProfilePic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .zIndex(Double(selectedMembers.count-index))
                }
                Spacer()
            }
            .padding(.leading, 25)
            .padding(.bottom, 150)

            Button("Criar projeto", action: createProject)

            .buttonStyle(.borderedProminent)
            
            // Não precisa desse botão pq quando vc roda a partir da root (loginview)
            // E faz o fluxo do app, a navigationStack já cria um botão de voltar lá em cima
            // Button("Agora não", action: back)

        }
        .sheet(isPresented: $showModal) {
            ModalView(
                selectedMembers: selectedMembers
            ) { members in
                self.selectedMembers = members
            }
        }
    }
    
    
    func createProject() {
        let projectToCreate = Project(
            title: self.title,
            members: self.selectedMembers,
            tasks: []
        )
        self.database.createProject(project: projectToCreate)
        // Project created!
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func openAddMembersModal() {
        showModal = true
    }
//    func back() {
//        self.presentationMode.wrappedValue.dismiss()
//    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentation
        
    @State var selectedMembers: Array<String>
    @State var currentMemberValue: String = ""
    var memberInputTitle: String = "E.g. Luke Skywalker"
    var autocompletePossibleGuesses = Constants.membersAutocomplete
    var autocompleteActualGuesses: Array<String> = []
    
    var onAdd: (Array<String>) -> Void
    
    var body: some View {
        VStack(){
            Text("Add new members")
                .bold()
                .padding()
                .font(.system(size: 30))
            ScrollView(.horizontal) {
                HStack(){
                    ForEach(selectedMembers, id: \.self) { member in
                        Chip(
                            systemImage: "xmark.circle",
                            titleKey: member
                        ) { titleKey in
                            deleteGuess(guess: titleKey)
                        }
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
            }
            
            TextField(memberInputTitle, text: $currentMemberValue)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            
            ForEach(searchResults, id: \.self) { guess in
                Button(action: {
                    addGuess(guess: guess)
                }) {
                    Text(guess)
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            
            Spacer()
            
            Button(action: {
                onAdd(self.selectedMembers)
                presentation.wrappedValue.dismiss()
            }, label: {
                Label("Adicionar", systemImage: "plus")
            })
            .padding(.bottom, 20)
            Button(action: {
                presentation.wrappedValue.dismiss()
            }, label: {
                Label("Fechar", systemImage: "xmark.circle")
            })
        }
    }
    
    func addGuess(guess: String) {
        if (!self.selectedMembers.contains(guess)) {
            self.selectedMembers.append(guess)
        }
    }
    
    func deleteGuess(guess: String) {
        self.selectedMembers = self.selectedMembers.filter{ $0 != guess }
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

struct CreateProject_Previews: PreviewProvider {
    static var previews: some View {
        CreateProject().environmentObject(Database(
            projects: [],
            userTasks: [],
            userRating: Rating(dev: 1, design: 1, innovation: 1)
        ))
    }
}
