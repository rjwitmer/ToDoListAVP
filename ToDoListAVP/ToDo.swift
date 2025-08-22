//
//  ToDo.swift
//  ToDoListAVP
//
//  Created by Bob Witmer on 2025-08-22.
//

import Foundation
import SwiftData

@Model
class ToDo {
    var item: String = ""
    var reminderIsOn: Bool = false
    var dueDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    var notes: String = ""
    var isCompleted: Bool = false
    
    init(item: String, reminderIsOn: Bool, dueDate: Date, notes: String, isCompleted: Bool) {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
    }
}

