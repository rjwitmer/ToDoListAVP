//
//  ToDo.swift
//  ToDoListAVP
//
//  Created by Bob Witmer on 2025-08-22.
//

import Foundation
import SwiftData

@MainActor
@Model
class ToDo {
    var item: String = ""
    var reminderIsOn: Bool = false
    var dueDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    var notes: String = ""
    var isCompleted: Bool = false
    
    init(item: String = "", reminderIsOn: Bool = false, dueDate: Date = Date.now + (60*60*24), notes: String = "", isCompleted: Bool = false) {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
    }
}

extension ToDo {
    
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: ToDo.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        // Add mock data here
        container.mainContext.insert(ToDo(item: "Create SwiftData", reminderIsOn: true, dueDate: Date.now + 60*60*24, notes: "Now with iOS 16 & Xcode 18", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Montenegrin Educators Talk", reminderIsOn: false, dueDate: Date.now + 60*60*44, notes: "They want to learn about entrepreneurship", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Post Flyers for Swift in Santiago", reminderIsOn: true, dueDate: Date.now + 60*60*72, notes: "To be held at UAH in Chile", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Prepare old iPhone for Lily", reminderIsOn: false, dueDate: Date.now + 60*60*12, notes: "She gets my old pro", isCompleted: false))
        
        return container
    }
}
