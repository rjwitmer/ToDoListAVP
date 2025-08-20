//
//  ToDoListView.swift
//  ToDoListAVP
//
//  Created by Bob Witmer on 2025-08-19.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ToDoListView: View {
    var toDoItems: [String] = [
        "Learn Swift",
        "Build Apps",
        "Change the World",
        "Bring the Awesomme",
        "Take a Vacation",
        "Take a Nap"
    ]
    var body: some View {

        NavigationStack {
            
            List {
                ForEach(toDoItems, id: \.self) { toDoItem in
                    NavigationLink {
                        DetailView(passedValue: toDoItem)
                    } label: {
                        Text(toDoItem)
                    }
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.automatic)
            .padding()
            
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ToDoListView()
}
