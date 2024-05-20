//
//  ContentView.swift
//  Calculator
//
//  Created by Deep Awasthi on 20/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.3), .purple.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            KeyView()
        }
    }
}

#Preview {
    ContentView()
}
