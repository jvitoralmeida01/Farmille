//
//  Database.swift
//  Farmille
//
//  Created by Zebra on 23/04/23.
//

import SwiftUI

class Task: ObservableObject {
    enum Field: String {
        case design
        case development
        case bussiness
    }
    
    @Published var id: Int
    @Published var title: String
    @Published var field: Field
    @Published var description: String
    @Published var estimate: Int
    
    init(id: Int, title: String, field: Field, description: String, estimate: Int) {
        self.id = id
        self.title = title
        self.field = field
        self.description = description
        self.estimate = estimate
    }
}

class Project: ObservableObject {
    @Published var id: Int
    @Published var title: String
    @Published var members: Array<String>
    @Published var tasks: Array<Task>
    
    init(id: Int, title: String, members: Array<String>, tasks: Array<Task>) {
        self.id = id
        self.title = title
        self.members = members
        self.tasks = tasks
    }
}

class Database: ObservableObject {
    @Published var projects: Array<Project>
    
    func createTask(projectId: Int, task: Task) {
        if let project = self.projects.first(where: {$0.id == projectId}) {
            project.tasks.append(task)
        }
    }
    
    func createProject(project: Project) {
        self.projects.append(project)
    }

    init(projects: Array<Project>) {
        self.projects = projects
    }
}
