import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartStore
    @State private var showCheckout = false

    var body: some View {
        Group {
            if cart.items.isEmpty {
                ContentUnavailableView("Your cart is empty",
                                       systemImage: "cart",
                                       description: Text("Add something from the shop to get started."))
            } else {
                List {
                    ForEach(cart.items) { item in
                        CartRow(item: item)
                    }
                    .onDelete { offsets in
                        offsets.map { cart.items[$0].product }.forEach(cart.remove)
                    }

                    Section {
                        HStack {
                            Text("Total").font(.headline)
                            Spacer()
                            Text(cart.total.currency).font(.headline)
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Button {
                        showCheckout = true
                    } label: {
                        Text("Checkout").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding()
                    .background(.bar)
                }
            }
        }
        .navigationTitle("Cart")
        .sheet(isPresented: $showCheckout) {
            CheckoutView()
        }
    }
}

struct CartRow: View {
    @EnvironmentObject var cart: CartStore
    let item: CartItem

    var body: some View {
        HStack(spacing: 12) {
            ProductImage(symbol: item.product.symbol, size: 22)
                .frame(width: 52, height: 52)

            VStack(alignment: .leading, spacing: 2) {
                Text(item.product.name).font(.subheadline.weight(.semibold))
                Text(item.product.price.currency)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack(spacing: 10) {
                Button { cart.decrement(item.product) } label: { Image(systemName: "minus.circle") }
                Text("\(item.quantity)").monospacedDigit().frame(minWidth: 20)
                Button { cart.add(item.product) } label: { Image(systemName: "plus.circle") }
            }
            .buttonStyle(.borderless)
            .font(.title3)
        }
    }
}
