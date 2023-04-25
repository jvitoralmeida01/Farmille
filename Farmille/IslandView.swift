//
//  IslandView.swift
//  Farmille
//
//  Created by Joao Almeida on 04/04/23.
//

import SwiftUI

struct TaskDetailView: View {
    var task: Task
    var body: some View {
        GeometryReader { bounds in
            HStack{
                Spacer()
                VStack {
                    Text(task.title)
                        .font(.system(size: 25))
                        .bold()
                        .padding(.bottom, 10)
                    Image("Pig")
                        .resizable()
                        .frame(
                            width: 150,
                            height: 150
                        )
                    Text(task.description)
                        .font(.system(size: 15))
                        .padding(.bottom, 10)
                    Text("Tempo estimado (dias): \(task.estimate)")
                    Spacer()
                }
                .padding(.top, 40)
                Spacer()
            }
        }
    }
}

struct IslandView: View {
    @ObservedObject var project: Project
    let imageName: String = "IslandTile" // image name
    
    @State var showDetail = false
    @State var showNewTask = false
    @State private var selectedTile = -1
    
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: rows), spacing: 0) {
            ForEach(0..<(rows*cols)) { index in
                ZStack {
                    if selectedTile == index {
                        Rectangle()
                            .fill(Color.black.opacity(0.15))
                            .frame(
                                width: .infinity,
                                height: .infinity)
                            .blur(radius: 10)
                            .offset(x: 0, y: UIScreen.main.bounds.height/100)
                            .zIndex(-1)
                    }
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical, -(height/100))
                        .padding(.horizontal, -1)
                        .overlay(
                            GeometryReader { bounds in
                                VStack{
                                    if (index < taskCount) {
                                        Image("Pig")
                                            .resizable()
                                            .frame(
                                                width: bounds.size.width * 0.7,
                                                height: bounds.size.height * 0.7
                                            )
                                    } else if (index == (rows*cols)-1) {
                                        NavigationLink(destination: CreateTask(project: project)) {
                                            Image.init(systemName: "plus.circle.fill").font(.system(size: 60))
                                                .padding(.horizontal, 10)
                                        }
                                    }
                                }
                                .padding()
                            }
                        )
                        .offset(y: (selectedTile == index ? -height/40 : 0))
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)) {
                                // animate changes to the imageSize state
                                if (index != (rows*cols)-1) {
                                    selectedTile = selectedTile == index ? -1 : index
                                    showDetail = selectedTile < taskCount && selectedTile >= 0
                                }
                            }
                        }
                        .zIndex(0)
                }
            }
        }
        .frame(width: 350)

        .sheet(isPresented: $showDetail) {
            let selectedTask = tasks[selectedTile]
            TaskDetailView(task: selectedTask)
                .presentationDetents([.height(70), .large])
        }
    }
    
    var tasks: Array<Task> {
        return project.tasks
    }
    
    var taskCount: Int {
        return self.tasks.count
    }
    
    var cols: Int {
        return rows
    }
    
    var rows: Int {
        let tileCount = Int(floor(Double(taskCount).squareRoot() + 1))
        return max(3, tileCount)
    }
}

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        IslandView(project: Project(id: 1, title: "Projeto 1", members: [], tasks: [
            Task(id: 1, title: "test", field: .design, description: "desctest", estimate: 3)
        ]))
    }
}
