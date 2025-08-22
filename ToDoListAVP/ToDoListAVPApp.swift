//
//  ToDoListAVPApp.swift
//  ToDoListAVP
//
//  Created by Bob Witmer on 2025-08-19.
//

import SwiftUI
import SwiftData

@main
struct ToDoListAVPApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .modelContainer(for: ToDo.self)
        }
    }
    
    // Will allow us to find where our simulator data is saved
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
