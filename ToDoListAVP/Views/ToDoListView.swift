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

enum SortOption: String, CaseIterable {
    case unsorted = "Unsorted"
    case alphabetical = "A-Z"
    case chronological = "Date"
    case completed = "Not Done"
}

struct SortedToDoList: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var toDoItems: [ToDo]
    let sortSelection: SortOption
    
    init(sortSection: SortOption) {
        self.sortSelection = sortSection
        switch self.sortSelection {
        case .unsorted:
            _toDoItems = Query()
        case .alphabetical:
            _toDoItems = Query(sort: \.item, animation: .default)
        case .chronological:
            _toDoItems = Query(sort: \.dueDate)
        case .completed:
            _toDoItems = Query(filter: #Predicate {$0.isCompleted == false})
        }
    }
    
    var body: some View {
        List {
            ForEach(toDoItems) { toDo in
                VStack (alignment: .leading) {
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
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
                    .font(.title2)
                }
                HStack {
                    Text(toDo.dueDate.formatted(date: .abbreviated, time: .shortened))
                        .foregroundStyle(.secondary)
                    if toDo.reminderIsOn {
                        Image(systemName: "calendar.badge.clock")
                            .symbolRenderingMode(.multicolor)
                    }
                }
            }
        }
        .listStyle(.plain)
        
    }
}

struct ToDoListView: View {
    @State private var sheetIsPresented: Bool = false
    @State private var sortSelection: SortOption = .unsorted
    
    
    var body: some View {
        
        NavigationStack {
            SortedToDoList(sortSection: sortSelection)
            
                .navigationTitle("To Do List")
                .navigationBarTitleDisplayMode(.automatic)
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
                    ToolbarItem(placement: .bottomBar) {
                        Picker("Sort By:", selection: $sortSelection) {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                Text(option.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .padding()
            
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ToDoListView()
        .modelContainer(ToDo.preview)   // Use mock data in preview
}
