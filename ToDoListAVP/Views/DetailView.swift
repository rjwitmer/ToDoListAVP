//
//  DetailView.swift
//  ToDoListAVP
//
//  Created by Bob Witmer on 2025-08-19.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @State var toDo: ToDo
    @State private var item = ""
    @State private var reminderIsOn: Bool = false
//    @State private var dueDate: Date = Date.now + 60*60*24
    @State private var dueDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    @State private var notes: String = ""
    @State private var isCompleted: Bool = false
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List {
            TextField("Enter To Do Item Here", text: $item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            
            Toggle("Set Reminder:", isOn: $reminderIsOn)
                .padding(.top)
                .listRowSeparator(.hidden)
            
            DatePicker("Date:", selection: $dueDate)
                .listRowSeparator(.hidden)
                .datePickerStyle(.automatic)
                .padding(.bottom)
                .disabled(!reminderIsOn)
            
            Text("Notes:")
                .padding(.top)
            
            TextField("Notes", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
                .listRowSeparator(.hidden)
            
            Toggle("Completed:", isOn: $isCompleted)
                .padding(.top)
                .listRowSeparator(.hidden)
            
        }
        .listStyle(.automatic)
        .onAppear() {
            item = toDo.item
            reminderIsOn = toDo.reminderIsOn
            dueDate = toDo.dueDate
            notes = toDo.notes
            isCompleted = toDo.isCompleted
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    // Move data from local vars to the toDo object
                    toDo.item = item
                    toDo.reminderIsOn = reminderIsOn
                    toDo.dueDate = dueDate
                    toDo.notes = notes
                    toDo.isCompleted = isCompleted
                    // Save the data to SwiftData modelContext
                    modelContext.insert(toDo)
                    // Save the data to SwiftData data store
                    guard let _ = try? modelContext.save() else {
                        print("😡 ERROR: Failed to save data to the data store!")
                        return
                    }
                    // Return to parent view
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(toDo: ToDo(item: "Sample To Do Item", reminderIsOn: false, dueDate: Date.now, notes: "Sample Notes", isCompleted: false))
            .modelContainer(for: ToDo.self, inMemory: true)
    }
}
