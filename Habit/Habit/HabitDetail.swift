//
//  HabitDetail.swift
//  Habit
//
//  Created by rokcso on 2024/1/22.
//

import SwiftUI

struct HabitDetail: View {
    @Binding var habit: HabitItem
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Label(habit.type, systemImage: "tag")
                        .font(.headline)
                        .foregroundColor(.orange)
                    Spacer()
                }
                Text(habit.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 5)
                Divider()
                HStack {
                    Text("Progress")
                        .font(.headline)
                    Spacer()
                    Text("\(habit.markedNum) of \(habit.targetNum)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                ProgressView(value: habit.progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .green))
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                    .padding(.vertical)
                
                Button(action: {
                    if habit.markedNum < habit.targetNum {
                        habit.markedNum += 1
                    }
                }, label: {
                    Text("Mark +1")
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .padding()
                        .font(.title3.weight(.bold))
                        .background(habit.markedNum < habit.targetNum ? Color.orange : Color.gray )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                })
                Spacer()
                
            }
            .padding()
            .navigationTitle(habit.title)
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
//    @State var habit = HabitItem(title: "早睡早起", type: "Personal", description: "这是不可能的。", markedNum: 10, targetNum: 20)
    return HabitDetail(habit: .constant(HabitItem(title: "早睡早起", type: "Personal", description: "这是不可能的。", markedNum: 10, targetNum: 20)))
}
