//
//  Bookworm2App.swift
//  Bookworm2
//
//  Created by 中木翔子 on 2022/08/07.
//

import SwiftUI

@main
struct Bookworm2App: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
