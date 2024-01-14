//
//  ContentView.swift
//  Moonshot
//
//  Created by rokcso on 2024/1/14.
//


import SwiftUI


struct ContentView: View {
    var body: some View {
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        let columns = [
            GridItem(.adaptive(minimum: 150, maximum: 200))
        ]
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) {
                        mission in
                        NavigationLink {
                            MissionView(mission: mission)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.launchDate ?? "N/A")
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                                
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .navigationTitle("Mooshot")
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
        
    }
}


#Preview {
    ContentView()
}
