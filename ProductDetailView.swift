import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cart: CartStore
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ProductImage(symbol: product.symbol, size: 90)
                    .frame(height: 260)

                Text(product.name)
                    .font(.title.bold())

                Text(product.price.currency)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color.accentColor)

                Text(product.description)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
        .safeAreaInset(edge: .bottom) {
            addToCartBar
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private var addToCartBar: some View {
        let quantity = cart.quantity(of: product)

        return HStack(spacing: 12) {
            if quantity > 0 {
                HStack(spacing: 14) {
                    Button { cart.decrement(product) } label: { Image(systemName: "minus.circle") }
                    Text("\(quantity)").monospacedDigit().frame(minWidth: 24)
                    Button { cart.add(product) } label: { Image(systemName: "plus.circle") }
                }
                .font(.title2)
            }

            Button {
                cart.add(product)
            } label: {
                Text(quantity == 0 ? "Add to Cart" : "Add Another")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
        .background(.bar)
    }
}
