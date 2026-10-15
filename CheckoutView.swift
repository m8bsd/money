import SwiftUI

/// Demo checkout: validates the form and "places" an order locally.
/// No real payment is processed — plug in Apple Pay / Stripe where noted.
struct CheckoutView: View {
    @EnvironmentObject var cart: CartStore
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var email = ""
    @State private var address = ""
    @State private var orderPlaced = false

    private var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        email.contains("@") && email.contains(".") &&
        !address.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            if orderPlaced {
                confirmation
            } else {
                form
            }
        }
    }

    private var form: some View {
        Form {
            Section("Contact") {
                TextField("Full name", text: $name)
                    .textContentType(.name)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }

            Section("Shipping address") {
                TextField("Street, city, postcode", text: $address, axis: .vertical)
                    .textContentType(.fullStreetAddress)
                    .lineLimit(2...4)
            }

            Section("Order summary") {
                ForEach(cart.items) { item in
                    HStack {
                        Text("\(item.quantity) × \(item.product.name)")
                        Spacer()
                        Text(item.subtotal.currency).foregroundStyle(.secondary)
                    }
                    .font(.subheadline)
                }
                HStack {
                    Text("Total").bold()
                    Spacer()
                    Text(cart.total.currency).bold()
                }
            }

            Section {
                Button("Place Order") {
                    // TODO: send the order to your backend / payment provider here.
                    cart.clear()
                    orderPlaced = true
                }
                .disabled(!isValid)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Checkout")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
        }
    }

    private var confirmation: some View {
        ContentUnavailableView {
            Label("Order placed", systemImage: "checkmark.circle.fill")
                .foregroundStyle(.green)
        } description: {
            Text("Thanks, \(name). A confirmation will be sent to \(email).")
        } actions: {
            Button("Continue Shopping") { dismiss() }
                .buttonStyle(.borderedProminent)
        }
    }
}
