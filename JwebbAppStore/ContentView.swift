//
//  ContentView.swift
//  JwebbAppStore
//
//  Created by Aleksey Lovchikov on 14/09/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 16).frame(width: 80, height: 80)
                        
                        VStack(alignment: .leading) {
                            Text("Youtube: Watch, Listen, blah, blah, blah")
                                .lineLimit(1).font(.system(size: 20))
                            Text("Photo & Video").foregroundStyle(Color(.gray))
                            Text("STARS 32.0M")
                        }
                        
                        Image(systemName: "icloud.and.arrow.down")
                    }
                    HStack {
                        RoundedRectangle(cornerRadius: 12).frame(height: 200)
                    }
                }
                .padding()
            }
            .navigationTitle("Search")
            .searchable(text: .constant("Enter search term"))
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
