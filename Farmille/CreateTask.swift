//
//  CreateTask.swift
//  Farmille
//
//  Created by Joao Almeida on 30/03/23.
//

import SwiftUI

struct CreateTask: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var database: Database
    
    var project: Project

    @State private var title: String = ""

    @State private var description: String = ""

    @State private var selectedButtonIndices = Set<Int>()

    @State private var estimate: Int = 1

    var body: some View {

        VStack {
            Text("Nova Tarefa")
                .bold()
                .padding()
                .font(.system(size: 30))

            Image("Pig")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)

            TextField("Insira o nome da tarefa", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading)
                .padding(.trailing)
                .padding(.vertical, 30)

            VStack (alignment: .leading) {
                Text("Descrição:")
                    .bold()
                    .padding(.vertical)
                    .font(.system(size: 20))

                TextEditor(text: $description)
                    //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 100)
                    .background(Color.gray)
                    .cornerRadius(20)

                Text("Áreas:")
                    .bold()
                    .padding(.vertical)
                    .font(.system(size: 20))

                HStack(spacing: 20) {
                    Spacer()

                    Button("Dev") {
                        if selectedButtonIndices.contains(0) {
                            selectedButtonIndices.remove(0)
                        } else {
                            selectedButtonIndices.insert(0)
                        }
                    }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .foregroundColor(selectedButtonIndices.contains(0) ? .white : .black)
                        .background(selectedButtonIndices.contains(0) ? Color.blue : Color.gray)
                        .cornerRadius(4)

                            

                    Button("Design") {
                        if selectedButtonIndices.contains(1) {
                            selectedButtonIndices.remove(1)
                        } else {
                            selectedButtonIndices.insert(1)
                        }
                    }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .foregroundColor(selectedButtonIndices.contains(1) ? .white : .black)
                        .background(selectedButtonIndices.contains(1) ? Color.blue : Color.gray)
                        .cornerRadius(4)


                    Button("Inovação") {
                        if selectedButtonIndices.contains(2) {
                            selectedButtonIndices.remove(2)
                        } else {
                            selectedButtonIndices.insert(2)
                        }
                    }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .foregroundColor(selectedButtonIndices.contains(2) ? .white : .black)
                        .background(selectedButtonIndices.contains(2) ? Color.blue : Color.gray)
                        .cornerRadius(4)
                    
                    Spacer()
                }

                HStack {
                    Text("Dificuldade: ")

                        .bold()
                        
                        .padding(.vertical)

                        .font(.system(size: 20))
                    
                    Picker("", selection: $estimate) {
                        ForEach(1...5, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .multilineTextAlignment(.center)
                }

            }

            .padding(.bottom)
            .padding(.leading)
            .padding(.trailing)

            Button("Criar tarefa", action: createTask)
                .buttonStyle(.borderedProminent)
        }

    }
    
    func createTask() {
        let isDev = selectedButtonIndices.contains(0)
        let isDesign = selectedButtonIndices.contains(1)
        let isInnovation = selectedButtonIndices.contains(2)
        
        let fields = Fields(dev: isDev, design: isDesign, innovation: isInnovation)

        let newTask = Task(title: title, fields: fields, description: description, estimate: estimate)
        self.database.createTask(projectId: project.id, task: newTask)
        presentationMode.wrappedValue.dismiss()
    }

}



struct BorderButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {

        configuration.label

            .padding(10)

            .contentShape(Rectangle())

            .overlay(

                RoundedRectangle(cornerRadius: 8)

                    .stroke(lineWidth: 2)

                    .foregroundColor(configuration.isPressed ? .gray : .blue)

            )

    }

}



struct CreateTask_Previews: PreviewProvider {
    static var previews: some View {
        CreateTask(project: Project(title: "Projeto 1", members: [], tasks: [])).environmentObject(Database(
            projects: [],
            userTasks: [],
            userRating: Rating(dev: 1, design: 1, innovation: 1)
        ))
    }
}
