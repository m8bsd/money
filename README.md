# MiniShop

A small SwiftUI e-commerce app: product catalog with search and category filter, product detail, a persistent cart, and a demo checkout.

**Requires:** Xcode 15+, iOS 17+ (uses `ContentUnavailableView` and `NavigationStack`).

## Run it

1. In Xcode: **File ▸ New ▸ Project ▸ iOS ▸ App** (Interface: SwiftUI, Language: Swift), name it `MiniShop`.
2. Delete the generated `ContentView.swift` and the generated `...App.swift` file.
3. Drag all `.swift` files from this folder into the project (tick "Copy items if needed").
4. Press **Run**.

## Files

| File | Purpose |
|---|---|
| `ShopApp.swift` | App entry point, tab bar (Shop / Cart with badge) |
| `Models.swift` | `Product`, `CartItem`, sample catalog, price formatting |
| `CartStore.swift` | Observable cart: add / remove / quantity / total, saved to `UserDefaults` |
| `CatalogView.swift` | Grid of products, search, category filter |
| `ProductDetailView.swift` | Detail page with add-to-cart and quantity stepper |
| `CartView.swift` | Cart list with swipe-to-delete and total |
| `CheckoutView.swift` | Form validation and order confirmation (no real payment) |

## Next steps

- Replace `Product.sample` with a network call (`URLSession` + `Codable`) and load images with `AsyncImage`.
- Add real payments (Apple Pay via `PassKit`, or Stripe) where the `TODO` is in `CheckoutView`.
- Add order history and user accounts.
