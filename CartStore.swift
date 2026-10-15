import Foundation

@MainActor
final class CartStore: ObservableObject {
    @Published private(set) var items: [CartItem] = [] {
        didSet { save() }
    }

    private let storageKey = "minishop.cart"

    init() { load() }

    var itemCount: Int { items.reduce(0) { $0 + $1.quantity } }
    var total: Decimal { items.reduce(0) { $0 + $1.subtotal } }

    func quantity(of product: Product) -> Int {
        items.first { $0.product.id == product.id }?.quantity ?? 0
    }

    func add(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
    }

    func decrement(_ product: Product) {
        guard let index = items.firstIndex(where: { $0.product.id == product.id }) else { return }
        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }

    func remove(_ product: Product) {
        items.removeAll { $0.product.id == product.id }
    }

    func clear() { items.removeAll() }

    // MARK: - Persistence (stores product ids + quantities only)

    private func save() {
        let payload = items.map { ["id": $0.product.id, "qty": $0.quantity] }
        UserDefaults.standard.set(payload, forKey: storageKey)
    }

    private func load() {
        guard let payload = UserDefaults.standard.array(forKey: storageKey) as? [[String: Int]] else { return }
        items = payload.compactMap { entry in
            guard let id = entry["id"], let qty = entry["qty"],
                  let product = Product.sample.first(where: { $0.id == id }) else { return nil }
            return CartItem(product: product, quantity: qty)
        }
    }
}
