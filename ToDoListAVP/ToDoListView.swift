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
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.circle.fill" : "circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding(.trailing)
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                                guard let _ = try? modelContext.save() else {
                                    print("😡 ERROR: Failed to save toggle change.")
                                    return
                                }
                            }
                        NavigationLink {
                            DetailView(toDo: toDo.self)
                        } label: {
                            Text(toDo.item)
                        }
                        .font(.title2)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(toDo)
                                guard let _ = try? modelContext.save() else {
                                    print("😡 ERROR: Failed to save deletion change.")
                                    return
                                }
                            }
                        }
                    }
                    .font(.title)
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
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
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
