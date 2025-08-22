//
//  ToDoListView.swift
//  ToDoListAVP
//
//  Created by Bob Witmer on 2025-08-19.
//

import SwiftUI
import RealityKit
import RealityKitContent
import SwiftData

struct ToDoListView: View {
    @State private var sheetIsPresented: Bool = false
    @Environment(\.modelContext) var modelContext
    @Query var toDoItems: [ToDo]

    var body: some View {

        NavigationStack {
            
            List {
                ForEach(toDoItems) { toDo in
                    NavigationLink {
                        DetailView(toDo: ToDo(item: toDo.item, reminderIsOn: toDo.reminderIsOn, dueDate: toDo.dueDate, notes: toDo.notes, isCompleted: toDo.isCompleted))
                    } label: {
                        Text(toDo.item)
                    }
                    .font(.title2)
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.automatic)
            .sheet(isPresented: $sheetIsPresented) {        // Could also use .fullScreenCover instead of .sheet
                NavigationStack {
                    DetailView(toDo: ToDo(item: "", reminderIsOn: false, dueDate: Date.now, notes: "", isCompleted: false))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .padding()
            
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ToDoListView()
        .modelContainer(for: ToDo.self, inMemory: true)
}
