import Foundation

struct Product: Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let price: Decimal
    let symbol: String      // SF Symbol used as the product image
    let category: Category

    enum Category: String, CaseIterable, Identifiable {
        case all = "All"
        case audio = "Audio"
        case wearables = "Wearables"
        case accessories = "Accessories"

        var id: String { rawValue }
    }
}

struct CartItem: Identifiable, Hashable {
    let product: Product
    var quantity: Int

    var id: Int { product.id }
    var subtotal: Decimal { product.price * Decimal(quantity) }
}

extension Product {
    static let sample: [Product] = [
        Product(id: 1, name: "Wireless Headphones",
                description: "Over-ear headphones with active noise cancellation and 30 hours of battery life.",
                price: 129.99, symbol: "headphones", category: .audio),
        Product(id: 2, name: "Bluetooth Speaker",
                description: "Portable, water-resistant speaker with deep bass and 12 hours of playtime.",
                price: 59.00, symbol: "hifispeaker", category: .audio),
        Product(id: 3, name: "Smart Watch",
                description: "Track workouts, sleep and notifications with a bright always-on display.",
                price: 199.50, symbol: "applewatch", category: .wearables),
        Product(id: 4, name: "Fitness Band",
                description: "Lightweight band with heart-rate monitoring and a 14-day battery.",
                price: 39.99, symbol: "figure.run", category: .wearables),
        Product(id: 5, name: "Laptop Stand",
                description: "Adjustable aluminium stand that lifts your screen to eye level.",
                price: 34.90, symbol: "laptopcomputer", category: .accessories),
        Product(id: 6, name: "Mechanical Keyboard",
                description: "Compact wireless keyboard with hot-swappable switches.",
                price: 89.00, symbol: "keyboard", category: .accessories),
        Product(id: 7, name: "Camera Lens Kit",
                description: "Clip-on wide-angle and macro lenses for your phone.",
                price: 24.99, symbol: "camera", category: .accessories),
        Product(id: 8, name: "Earbuds",
                description: "True wireless earbuds with a compact charging case.",
                price: 79.99, symbol: "earbuds", category: .audio)
    ]
}

extension Decimal {
    var currency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: self as NSDecimalNumber) ?? "$\(self)"
    }
}
