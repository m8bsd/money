import SwiftUI

@main
struct ShopApp: App {
    @StateObject private var cart = CartStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(cart)
        }
    }
}

struct RootView: View {
    @EnvironmentObject var cart: CartStore

    var body: some View {
        TabView {
            NavigationStack {
                CatalogView()
            }
            .tabItem { Label("Shop", systemImage: "bag") }

            NavigationStack {
                CartView()
            }
            .tabItem { Label("Cart", systemImage: "cart") }
            .badge(cart.itemCount)
        }
    }
}
