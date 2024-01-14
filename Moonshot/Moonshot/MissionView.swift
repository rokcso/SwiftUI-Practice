//
//  MissionView.swift
//  Moonshot
//
//  Created by rokcso on 2024/1/14.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
//    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) {
                        width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.weight(.bold))
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                }
                .padding(.horizontal)
            }
        }
    }
    
    
}


#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    return MissionView(mission: missions[0])
        .preferredColorScheme(.dark)
}
