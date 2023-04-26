//
//  ProjectView.swift
//  Farmille
//
//  Created by Joao Almeida on 04/04/23.
//

import SwiftUI

struct ProjectView: View {
    @EnvironmentObject private var database: Database
    
    @State private var projectCarouselIndex = 0
    
    var body: some View {
        VStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.blue]),
                startPoint: .top,
                endPoint: .bottom
            )
                .ignoresSafeArea()
                .overlay(
                    TabView(selection: $projectCarouselIndex) {
                        ForEach((0..<projectCount+1), id: \.self) {index in
                            if (index != projectCount) {
                                VStack {
                                    Text(projects[index].title)
                                        .padding(.bottom, 70)
                                        .font(.system(size: 35))
                                        .bold()
                                    IslandView(project: projects[index])
                                }
                            } else {
                                NavigationLink(destination: CreateProject()) {
                                    Image.init(systemName: "plus").font(.system(size: 80))
                                }
                            }
                        }
                    }
                    .padding(.top, -100)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 520)
                )
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    var projectCount: Int {
        return self.database.projects.count
    }
    
    var projects: Array<Project> {
        return self.database.projects
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView().environmentObject(Database(
            projects: [Project(title: "Projeto 1", members: [], tasks: [])],
            userTasks: [Task(title: "task1", fields: Fields(), description: "desctest", estimate: 3)],
            userRating: Rating(dev: 1, design: 1, innovation: 1)
        ))
    }
}
