//
//  ContentView.swift
//  JwebbAppStore
//
//  Created by Aleksey Lovchikov on 14/09/2024.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
}

struct SearchView: View {
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ScrollView {
                    ForEach(0..<10) { num in
                        VStack(spacing: 16) {
                            AppIconTitleView()
                            
                            ScreenshotsRow(proxy: proxy)
                        }
                        .padding(16)
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: .constant("Enter search term"))
        }
    }
}

struct AppIconTitleView: View {
    var body: some View {
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
    }
}

struct ScreenshotsRow: View {
    let proxy: GeometryProxy
    
    var body: some View {
        let width = (proxy.size.width - 4 * 16) / 3
        
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: width, height: 200)
            
            RoundedRectangle(cornerRadius: 12)
                .frame(width: width, height: 200)
            
            RoundedRectangle(cornerRadius: 12)
                .frame(width: width, height: 200)
        }
    }
}

#Preview {
    SearchView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
