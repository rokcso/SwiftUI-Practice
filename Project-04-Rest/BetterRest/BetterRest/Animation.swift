//
//  Animation.swift
//  BetterRest
//
//  Created by rokcso on 2024/1/7.
//

import SwiftUI

struct Animation: View {
    @State private var showRe = false
    
    struct CornerRotateModifier: ViewModifier {
        let amount: Double
        let anchor: UnitPoint
        
        func body(content: Content) -> some View {
            content
                .rotationEffect(.degrees(amount), anchor: anchor)
                .clipped()
        }
    }
    
    extension AnyTransition {
        static var pivot: AnyTransition {
            .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
        }
    }
    
    var body: some View {
        VStack {
            Button("Tap") {
                withAnimation {
                    showRe.toggle()
                }
            }
            
            if showRe {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

#Preview {
    Animation()
}
