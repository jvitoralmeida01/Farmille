//
//  CreateProject.swift
//  Farmille
//
//  Created by Joao Almeida on 30/03/23.
//

import SwiftUI

struct CreateProject: View {

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

                Button("Add more +", action: addMembers)

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

            Button("Create project", action: createProject)

            .buttonStyle(.borderedProminent)

            Button("Not now", action: back)

        }

    }

}



func createProject() {

    print("Hello, World!")

}



func back() {

    print("Hello, World!")

}



func addMembers() {

    print("Hello, World!")

}

struct CreateProject_Previews: PreviewProvider {
    static var previews: some View {
        CreateProject()
    }
}
