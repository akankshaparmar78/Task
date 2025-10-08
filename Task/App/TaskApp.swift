//
//  TaskApp.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import SwiftUI

@main
struct TaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                SearchView()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
