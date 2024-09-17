//
//  ContentView.swift
//  JwebbAppStore
//
//  Created by Aleksey Lovchikov on 14/09/2024.
//

import SwiftUI

struct Result: Codable, Identifiable {
    var id: Int { trackId }
    
    let trackId: Int
    let trackName: String
    let artworkUrl512: String
    let primaryGenreName: String
    let screenshotUrls: [String]
    let artistName: String
}

struct SearchResult: Codable {
    let results: [Result]
}

@MainActor
class SearchViewModel: ObservableObject {
    @Published var results: [Result] = [Result]()
    
    init() {
        fetchJSONData()
    }
    
    private func fetchJSONData() {
        Task {
            do {
                guard let url = URL(string: "https://itunes.apple.com/search?term=tinder&entity=software") else { return }
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                searchResult.results.prefix(3).forEach { result in
                    print(result.trackName)
                }
                
                self.results = searchResult.results
            } catch {
                print("Faile to fetch data: \(error.localizedDescription)")
            }
        }
    }
}

struct SearchView: View {
    @StateObject var vm = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ScrollView {
                    ForEach(vm.results) { result in
                        VStack(spacing: 16) {
                            AppIconTitleView(result: result)
                            
                            ScreenshotsRow(proxy: proxy, result: result)
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
    let result: Result
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: result.artworkUrl512)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading) {
                Text(result.trackName)
                    .lineLimit(1)
                    .font(.system(size: 20))
                
                Text(result.primaryGenreName)
                    .foregroundStyle(Color(.gray))
                
                Text("STARS 32.0M")
            }
            
            Spacer()
            
            Image(systemName: "icloud.and.arrow.down")
        }
    }
}

struct ScreenshotsRow: View {
    let proxy: GeometryProxy
    let result: Result
    
    var body: some View {
        let width = (proxy.size.width - 4 * 16) / 3
        
        HStack(spacing: 16) {
            ForEach(result.screenshotUrls.prefix(3), id: \.self) { screenshotsUrl in
                AsyncImage(url: URL(string: screenshotsUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: width,height: 200)
                }
            }
        }
    }
}

#Preview {
    SearchView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
