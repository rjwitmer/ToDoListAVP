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
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("To Do")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink {
                    DetailView()
                } label: {
                    Image(systemName: "eye")
                    Text("Show the Detail View!")
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)

                Spacer()

            }
            .padding()
        }

    }
}

#Preview(windowStyle: .automatic) {
    ToDoListView()
}
