//
//  ExpenseRow.swift
//  iExpense
//
//  Created by rokcso on 2024/1/13.
//

import SwiftUI

struct ExpenseRow: View {
    var item: ExpenseItem
    var currencyCode: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                Text(item.type)
                    .font(.headline.weight(.light))
            }
            Spacer()
            Text(item.amount, format: .currency(code: currencyCode))
                .style(for: item.amount)
        }
    }
}

#Preview {
    ExpenseRow(item: ExpenseItem(name: "测试", type: "Personal", amount: 100), currencyCode: "USD")
}
