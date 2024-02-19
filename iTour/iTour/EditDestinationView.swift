//
//  EditDestinationView.swift
//  iTour
//
//  Created by niein on 2024/2/19.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    @Bindable var destination: Destination // 详细信息编辑 View 一次只编辑处理一个对象的数据，由于编辑需要实际写（不能只是读）对象的数据，所有需要创建数据绑定
    // @Bindable 可以创建任何 SwiftData 对象的绑定
    
    @State private var newSightName = "" // 用来存储 Sight name 的临时变量
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                } // 显示当前 destination 已有的所有 sight
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        modelContext.delete(destination.sights[index])
                    }
                })
                
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    Button("Add", action: addSight)
                } // 向当前 destination 添加 sight
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight() {
        guard newSightName.isEmpty == false else { return } // 如果临时 sight name 不为空则退出
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
}

// 要让预览正常工作，需要手动创建一个临时的 Model container
#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true) // 创建 ModelConfiguration 对象以指定临时内存
        let container = try ModelContainer(for: Destination.self, configurations: config) // 使用上面指定的临时内存，为 Destination 对象，创建 Model container
        let example = Destination(name: "Text Destination", details: "This is an example destination", date: .now, priority: 1) // 创建一个测试数据对象
        return EditDestinationView(destination: example) // 将测试数据对象传入视图对返回
            .modelContainer(container) // 返回的视图需要包含临时 Model container
    } catch {
        fatalError("Failed to create model container.")
    }
}
