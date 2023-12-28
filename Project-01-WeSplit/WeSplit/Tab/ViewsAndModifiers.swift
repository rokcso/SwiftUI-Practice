//
//  ViewsAndModifiers.swift
//  WeSplit
//
//  Created by rokcso on 2023/12/28.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ViewsAndModifiers: View {
    
    @State private var redFlag: Bool = true
    
    var body: some View {
        
        Color.blue
            .frame(width: 300, height: 200)
            .watermarked(with: "Hacking with rokcso")
        
        VStack {
            Text("Gryffindor")
//                .font(.largeTitle)
//                .blur(radius: 0)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
//        .font(.title)
        .blur(radius: 0)
        
        Button("AAAAA") {
            redFlag.toggle()
        }
        .padding()
        .background(redFlag ? .red : .green)
        .frame(width: 200, height: 200)
        .background(.red)
        
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ViewsAndModifiers()
}
