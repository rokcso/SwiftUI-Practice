//
//  Order.swift
//  CupcakeCorner
//
//  Created by rokcso on 2024/1/24.
//

import SwiftUI

@Observable
class Order: Codable {
    
    static let types = ["Vanilla","Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quanity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var cost: Double {
        var cost = Double(quanity) * 2
        cost += (Double(type) / 2)
        if extraFrosting {
            cost += Double(quanity)
        }
        if addSprinkles {
            cost += (Double(quanity) / 2)
        }
        
        return cost
    }
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty || name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }
    
//    enum CodingKeys: String, CodingKey {
//        case _type = "type"
//        case _quantity = "quantity"
//        case _specialRequestEnabled = "specialRequestEnabled"
//        case _extraFrosting = "extraFrosting"
//        case _addSprinkles = "addSprinkles"
//        case _name = "name"
//        case _city = "city"
//        case _streetAddress = "streetAddress"
//        case _zip = "zip"
//    }
}

struct OrderView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("\(order.quanity) Cake(s)", value: $order.quanity, in: 1...100)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
            
            .navigationTitle("Order Cake")
        }
    }
}

#Preview {
    OrderView()
}
