//
//  IslandView.swift
//  Farmille
//
//  Created by Joao Almeida on 04/04/23.
//

import SwiftUI

struct SeededRandomNumberGenerator {
    private var seed: UInt64

    init(seed: UInt64) {
        self.seed = seed
    }

    private let a: UInt64 = 1664525
    private let c: UInt64 = 1013904223
    private let m: UInt64 = UInt64.max

    mutating func next() -> UInt64 {
        seed = (a * seed + c) % m
        return seed
    }

    mutating func nextInt(upperBound: Int) -> Int {
        return Int(next() % UInt64(upperBound))
    }
}

func randomNumber(seed: Int, upperBound: Int) -> Int {
    var generator = SeededRandomNumberGenerator(seed: UInt64(seed))
    return generator.nextInt(upperBound: upperBound)
}


struct TaskDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var database: Database
    @ObservedObject var task: Task
    @Binding var updateTrigger: Bool
    var body: some View {
        GeometryReader { bounds in
            HStack{
                Spacer()
                VStack {
                    Text(task.title)
                        .font(.system(size: 25))
                        .bold()
                        .padding(.bottom, 10)
                    if (task.isAssigned) {
                        GIFWebView(gifName: "pigAnimated")
                            .overlay(
                                Image("ProfilePic")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.bottom, bounds.size.height - 630)
                                    .padding(.leading, bounds.size.width - 270)
                            )
                            .frame(
                                width: 150,
                                height: 150
                            )
                    } else {
                        GIFWebView(gifName: "pigAnimated")
                    }
                    FieldPresenter(taskFields: task.fields)
                        .padding(.top, 20)
                    DificultyChip(difficultyLevel: difficultyEstimate)
                        .padding(.top, 5)
                    Text("Dificuldade: \(task.estimate)")
                        .foregroundColor(.black.opacity(0.6))
                    
                    Text(task.description)
                        .font(.system(size: 20))
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                    
                    if (!task.isAssigned) {
                        Button("Atribuir-se na atividade", action: {
                            assignTask()
                        })
                            .buttonStyle(.borderedProminent)
                    } else {
                        Button(action: {}, label: {
                            Label("Atribuído", systemImage: "checkmark")
                        })
                            .buttonStyle(.borderedProminent)
                            .disabled(true)
                            .padding(.bottom, 10)

                        // Só exibir botão de conclusão se atividade estiver assigned
                        if (!task.isCompleted) {
                            Button("Concluir atividade", action: {
                                completeTask()
                            })
                                .buttonStyle(.borderedProminent)
                                .tint(.green)
                        } else {
                            Button(action: {}, label: {
                                Label("Concluída", systemImage: "checkmark")
                            })
                                .buttonStyle(.borderedProminent)
                                .disabled(true)
                        }
                    }
                    Spacer()
                }
                .padding(.top, 40)
                Spacer()
            }
        }
    }
    var difficultyEstimate: Int {
        let userRatings = self.database.userRating
        
        var taskTotalRating = 0
        var userTotalRating = 0
        var fieldCount = 0
        
        if (task.fields.dev) {
            fieldCount += 1
            taskTotalRating += task.estimate
            userTotalRating += userRatings.dev
        }
        if (task.fields.design) {
            fieldCount += 1
            taskTotalRating += task.estimate
            userTotalRating += userRatings.design
        }
        if (task.fields.innovation) {
            fieldCount += 1
            taskTotalRating += task.estimate
            userTotalRating += userRatings.innovation
        }
        
        let dividend = 2.67 * Double(fieldCount)
        let sumDiff = 4 * fieldCount
        
        taskTotalRating -= userTotalRating
        taskTotalRating += sumDiff
        
        let estimateReturn = fieldCount == 0
        ? 1
        : Int(ceil(Double(taskTotalRating)/dividend))
        
        return estimateReturn
    }

    func completeTask() {
        self.task.isCompleted = true
        self.updateTrigger = !self.updateTrigger
        presentationMode.wrappedValue.dismiss()
    }
    func assignTask() {
        self.updateTrigger = !self.updateTrigger
        self.task.isAssigned = true
        
    }
}

struct IslandView: View {
    let pigImages = ["Pig1", "Pig2", "Pig3"]
    
    @ObservedObject var project: Project
    let imageName: String = "IslandTile" // image name
    
    @State var showDetail = false
    @State var showNewTask = false
    @State private var selectedTile = -1
    @State var updateTrigger: Bool = false
    
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
                            taskOverlay(index: index, pigImage: pigImages[randomNumber(seed: index, upperBound: 3)])
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
            TaskDetailView(task: selectedTask, updateTrigger: $updateTrigger)
                .presentationDetents([.height(70), .large])
        }
    }
    @ViewBuilder
    private func taskOverlay(index: Int, pigImage: String) -> some View {
            GeometryReader { bounds in
                VStack{
                    if (index < taskCount) {
                        if (tasks[index].isAssigned) {
                            Image(pigImage)
                                .resizable()
                                .overlay(
                                    Image("ProfilePic")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.bottom, bounds.size.height - 50)
                                        .padding(.leading, bounds.size.width - 50)
                                )
                                .frame(
                                    width: bounds.size.width * 0.7,
                                    height: bounds.size.height * 0.7
                                )
                        } else {
                            Image(pigImage)
                                .resizable()
                                .frame(
                                    width: bounds.size.width * 0.7,
                                    height: bounds.size.height * 0.7
                                )
                        }
                        
                        
                    } else if (index == (rows*cols)-1) {
                        NavigationLink(destination: CreateTask(project: project)) {
                            Image.init(systemName: "plus.circle.fill").font(.system(size: 60))
                                .padding(.horizontal, 10)
                        }
                    }
                }
                   .padding()
            }
        }
    
    var tasks: Array<Task> {
        if (updateTrigger) {
            // Isso aqui é só uma forma de propagar a mudança entre nested ObservedObjects
            // Um miguézinho
            print("passing")
        }
        let sortedTasks = project.tasks.sorted{ !$0.isCompleted && $1.isCompleted }.sorted{ $0.isAssigned && !$1.isAssigned }
        return sortedTasks
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
        let fields = Fields(dev: true, design: true)
        let task = Task(title: "task1", fields: fields, description: "desctest", estimate: 3)
        let task1 = Task(title: "task2", fields: fields, description: "desctest", estimate: 3)
        let task2 = Task(title: "task3", fields: fields, description: "desctest", estimate: 3)
        let task3 = Task(title: "task4", fields: fields, description: "desctest", estimate: 3)
        
        IslandView(project: Project(title: "Projeto 1", members: [], tasks: [
            task,
            task1,
            task2,
            task3
        ])).environmentObject(Database(
            projects: [],
            userTasks: [],
            userRating: Rating(dev: 3, design: 3, innovation: 1)
        ))
    }
}
