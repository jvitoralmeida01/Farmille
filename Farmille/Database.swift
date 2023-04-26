//
//  Database.swift
//  Farmille
//
//  Created by Zebra on 23/04/23.
//

import SwiftUI

class Fields: ObservableObject {
    @Published var dev: Bool
    @Published var design: Bool
    @Published var innovation: Bool
    
    init(dev: Bool = false, design: Bool = false, innovation: Bool = false) {
        self.dev = dev
        self.design = design
        self.innovation = innovation
    }
}

class Task: ObservableObject {
    @Published var id: String
    @Published var title: String
    @Published var fields: Fields
    @Published var description: String
    @Published var estimate: Int
    @Published var isAssigned: Bool
    @Published var isCompleted: Bool
    
    init(title: String, fields: Fields, description: String, estimate: Int, isAssigned: Bool = false, isCompleted: Bool = false) {
        self.id = UUID().uuidString
        self.title = title
        self.fields = fields
        self.description = description
        self.estimate = estimate
        self.isAssigned = isAssigned
        self.isCompleted = isCompleted
    }
}

class Project: ObservableObject {
    @Published var id: String
    @Published var title: String
    @Published var members: Array<String>
    @Published var tasks: Array<Task>
    
    init(title: String, members: Array<String>, tasks: Array<Task>) {
        self.id = UUID().uuidString
        self.title = title
        self.members = members
        self.tasks = tasks
    }
}

class Rating: ObservableObject {
    @Published var dev: Int
    @Published var design: Int
    @Published var innovation: Int
    
    init(dev: Int, design: Int, innovation: Int) {
        self.dev = dev
        self.design = design
        self.innovation = innovation
    }
}

class Database: ObservableObject {
    @Published var projects: Array<Project>
    @Published var userTasks: Array<Task>
    @Published var userRating: Rating
    @Published var lastUpdate: Date
    
    func createTask(projectId: String, task: Task) {
        if let project = self.projects.first(where: {$0.id == projectId}) {
            project.tasks.append(task)
            self.userTasks.append(task)
        }
    }
    
    func createProject(project: Project) {
        self.projects.append(project)
    }
    
    func saveUserRating(rating: Rating) {
        self.userRating = rating
    }

    init(projects: Array<Project>, userTasks: Array<Task>, userRating: Rating) {
        self.projects = projects
        self.userTasks = userTasks
        self.userRating = userRating
        self.lastUpdate = Date()
    }
}
