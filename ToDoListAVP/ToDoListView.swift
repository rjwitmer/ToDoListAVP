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
    @State private var sheetIsPresented: Bool = false
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
                        DetailView(toDoItem: toDoItem)
                    } label: {
                        Text(toDoItem)
                    }
                    .font(.title2)
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.automatic)
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(toDoItem: "")
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
}
