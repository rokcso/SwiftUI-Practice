//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by rokcso on 2024/1/23.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results: [Result] = [Result]()
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) {
                image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
//                Color.red
                ProgressView()
            }
            .frame(width: 100, height: 100)
            
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) {
                phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 100, height: 100)
            
            List(results, id: \.trackId) {
                item in
                VStack {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
//            print(results)
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
