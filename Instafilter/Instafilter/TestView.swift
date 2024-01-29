//
//  ContentView.swift
//  Instafilter
//
//  Created by rokcso on 2024/1/28.
//

import SwiftUI
import PhotosUI
import StoreKit

struct TestView: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .images) {
                Label("Select", systemImage: "photo")
            }
            
//            ScrollView {
//                ForEach(0..<selectedImages.count, id: \.self) {
//                    i in
//                    selectedImages[i]
//                        .resizable()
//                        .scaledToFit()
//                }
//            }
            
            ShareLink(
                item: URL(string: "https://rokcso.com")!,
                subject: Text("HAHAHAA"),
                message: Text("dslkjflskf")
            ) {
                Label("djsfklsdlfs", systemImage: "swift")
            }
            
            let ex = Image(.example)
            ShareLink(item: ex, preview: SharePreview("preview", image: ex)) {
                Label("Im", systemImage: "airplane")
            }
            
            Button("Leave a review") {
                requestReview()
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            
            }
        }
        
//        ContentUnavailableView {
//            Label("No snippets", systemImage: "swift")
//        } description: {
//            Text("You don't have any saved snippets yet.")
//        } actions: {
//            Button("Creat Snippets") {
//                print("Welcome!")
//            }
//            .buttonStyle(.borderedProminent)
//        }
    }
}

#Preview {
    TestView()
}
