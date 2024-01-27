//
//  EmojiRatingVIew.swift
//  Bookworm
//
//  Created by rokcso on 2024/1/27.
//

import SwiftUI

struct EmojiRatingVIew: View {
    let rating: Int
    
    var body: some View {
        switch rating {
        case 0:
            Text("🥚")
        case 1:
            Text("🤮")
        case 2:
            Text("😵‍💫")
        case 3:
            Text("😐")
        case 4:
            Text("🤔")
        case 5:
            Text("🤩")
        default:
            Text("🥚")
        }
    }
}

#Preview {
    EmojiRatingVIew(rating: 4)
}
