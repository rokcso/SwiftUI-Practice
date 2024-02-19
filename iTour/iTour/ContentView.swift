//
//  ContentView.swift
//  iTour
//
//  Created by niein on 2024/2/19.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var destinations: [Destination] // 使用 @Query 宏来读取 SwiftData 管理的所有 Destination 数据对象
    // @Query 会在该 View 显示时加载所有数据，并且将自动监视数据库的变化，并在数据库变化时自动更新 destinations 属性
    
    @Environment(\.modelContext) var modelContext // 访问已经存在的 Model context
    
    @State private var path = [Destination]()
    
    var body: some View {
        NavigationStack(path: $path) { // 绑定 NavigationStack 的 path
            List {
                ForEach(destinations) { destination in
                    NavigationLink(value: destination) { // 为 ForEach 的每一个项添加一个导航链接，传入的数据为当前项的数据
                        VStack(alignment: .leading) {
                            Text(destination.name)
                                .font(.headline)
                            
                            Text(destination.date.formatted(date: .long, time: .shortened))
                        }
                    }
                }
                .onDelete(perform: deleteDestinations) // 删除 ForEach 中的指定项
            }
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self) { destination in
                EditDestinationView(destination: destination)
            } // 点击 ForEach 项后导航到的目的地，将 Destination 对象的数据导航到 EditDestinationView
            
            .toolbar {
                Button("Add test", action: addTest)
                Button("Add", systemImage: "plus", action: addDestination)
            }
        }
    }
    
    // 添加一些测试数据
    func addTest() {
        let rome = Destination(name: "Rome")
        let florence = Destination(name: "Florence")
        let naples = Destination(name: "Naples")
        // 至此只是创建了一些 Destination 数据模型对象实例，并没有使用 SwiftData 进行存储，就无法进一步使用
        
        // 以下将刚刚创建的实例插入 model Context，即完成存储
        // 数据一旦被存储，将默认永久存储，重新运行之前的数据依然存在
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
    }
    
    // 删除指定数据
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            // 在 ForEach 中遍历所有项，通过项索引定位到具体的 destination
            let destination = destinations[index]
            // 在 model Context 中删除指定的 destination
            modelContext.delete(destination)
        }
    }
    
    // 添加数据
    func addDestination() {
        let destination = Destination(name: "NEW")
        modelContext.insert(destination)
        path = [destination] // 在 NavigationStack 的 path 数组中添加数据，视图将导航到带有该数据的视图
    }
}

#Preview {
    ContentView()
}
