//
//  FarmilleApp.swift
//  Farmille
//
//  Created by Joao Almeida on 30/03/23.
//

import SwiftUI

@main
struct FarmilleApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView().environmentObject(Database(
                projects: [],
                userTasks: [],
                userRating: Rating(dev: 1, design: 1, innovation: 1)
            ))
        }
    }
}


