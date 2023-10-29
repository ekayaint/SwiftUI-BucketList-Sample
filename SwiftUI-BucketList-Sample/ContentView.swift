//
//  ContentView.swift
//  SwiftUI-BucketList-Sample
//
//  Created by ekayaint on 29.10.2023.
//

import SwiftUI

struct User: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
