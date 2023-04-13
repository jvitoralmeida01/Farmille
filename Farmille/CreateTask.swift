//
//  CreateTask.swift
//  Farmille
//
//  Created by Joao Almeida on 30/03/23.
//

import SwiftUI

struct CreateTask: View {

    @State private var title: String = ""

    @State private var description: String = ""

    @State private var selectedButtonIndices = Set<Int>()

    @State private var number: Int = 1

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

                            Button("Desenvolvimento") {

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

                        }

                        .padding()

                HStack {
                    Text("Tempo total: \(number) dias")

                        .bold()
                        
                        .padding(.vertical)

                        .font(.system(size: 20))
                    
                    Picker("", selection: $number) {
                        ForEach(1...100, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .multilineTextAlignment(.center)
                    
                    .padding(.leading, 130)
                }

            }

            .padding(.bottom)

            .padding(.leading)

            .padding(.trailing)

            Button("Criar tarefa", action: createProject)

                .buttonStyle(.borderedProminent)

            Button("Agora não", action: back)

        }

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
        CreateTask()
    }
}
