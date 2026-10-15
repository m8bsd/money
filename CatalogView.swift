import SwiftUI

struct ProductImage: View {
    let symbol: String
    var size: CGFloat = 40

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.accentColor.opacity(0.12))
            Image(systemName: symbol)
                .font(.system(size: size))
                .foregroundStyle(Color.accentColor)
        }
    }
}

struct CatalogView: View {
    @EnvironmentObject var cart: CartStore
    @State private var searchText = ""
    @State private var category: Product.Category = .all

    private let columns = [GridItem(.adaptive(minimum: 160), spacing: 16)]

    private var filtered: [Product] {
        Product.sample.filter { product in
            (category == .all || product.category == category) &&
            (searchText.isEmpty || product.name.localizedCaseInsensitiveContains(searchText))
        }
    }

    var body: some View {
        ScrollView {
            Picker("Category", selection: $category) {
                ForEach(Product.Category.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(filtered) { product in
                    NavigationLink(value: product) {
                        ProductCard(product: product)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()

            if filtered.isEmpty {
                ContentUnavailableView.search(text: searchText)
            }
        }
        .navigationTitle("MiniShop")
        .searchable(text: $searchText, prompt: "Search products")
        .navigationDestination(for: Product.self) { ProductDetailView(product: $0) }
    }
}

struct ProductCard: View {
    @EnvironmentObject var cart: CartStore
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ProductImage(symbol: product.symbol)
                .frame(height: 110)

            Text(product.name)
                .font(.subheadline.weight(.semibold))
                .lineLimit(2, reservesSpace: true)
                .multilineTextAlignment(.leading)

            HStack {
                Text(product.price.currency)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Spacer()
                Button {
                    cart.add(product)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
                .accessibilityLabel("Add \(product.name) to cart")
            }
        }
        .padding(10)
        .background(.background.secondary, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
