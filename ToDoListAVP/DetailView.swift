//
//  DetailView.swift
//  ToDoListAVP
//
//  Created by Bob Witmer on 2025-08-19.
//

import SwiftUI

struct DetailView: View {
    var passedValue: String // Don't initialize it will be passed from the parent view
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.orange)
            
            Text("Welcome to DetailView!\nAnd you passed the value: \(passedValue)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Button("Go Back") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.blue)
        }
        .padding()
//        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DetailView(passedValue: "Item x")
}
