//
//  Animation.swift
//  BetterRest
//
//  Created by rokcso on 2024/1/7.
//

import SwiftUI

struct Animation: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        Button("Tap") {
//            animationAmount += 0.5
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .font(.title.weight(.bold))
//        .scaleEffect(animationAmount)
//        .blur(radius: (animationAmount - 1) * 3)
//        .animation(.easeInOut(duration: 2).delay(1).repeatCount(2, autoreverses: true), value: animationAmount)

        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount)
        )
        .onAppear {
            animationAmount = 2
        }
        
    }
}

#Preview {
    Animation()
}
