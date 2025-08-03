//
//  PaymetView.swift
//  RALLE app
//
//  Created by Michael Thomas on 7/23/25.
//

import SwiftUI
import Stripe
import StripePaymentSheet


struct PaymentView: View {
    let gearItem: GearItem
    let userId: Int
    @StateObject var viewModel = PaymentViewModel()
    @State private var isPaymentSheetPresented = false
    @Environment(\.dismiss) var dismiss
    @State private var showConfirmation = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("You are purchaseing \(gearItem.name)")
            Text("Checkout for $\(Double(gearItem.price) / 100.0, specifier: "%.2f")")
                .font(.title)
            Button("Pay With Card") {
                Task {
                    await viewModel.preparePaymentSheet(amount: gearItem.price) // in cents
                    DispatchQueue.main.async {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let rootVC = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                            print("Ready to present Payment Sheet from: \(rootVC)")
                            viewModel.presentPaymentSheet(controller: rootVC, item: gearItem)
                        } else {
                            print("Could not get root view controller")
                        }
                    }
                }
            }
            .disabled(viewModel.isPresentingPaymentSheet)
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
        
        .onReceive(viewModel.$paymentSucceeded) { success in
            print("paymentSucceeded triggered: \(success)")
            if success {
                showConfirmation = true
            }
        }
        .sheet(isPresented: $showConfirmation) {
            PaymentConfirmationView(gearItem: gearItem) {
                showConfirmation = false
                dismiss()
            }
        }   
    }
}

