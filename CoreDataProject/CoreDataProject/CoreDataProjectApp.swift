//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by 中木翔子 on 2022/09/05.
//

import SwiftUI


@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
