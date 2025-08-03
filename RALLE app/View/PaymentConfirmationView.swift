//
//  PaymentConfirmationView.swift
//  RALLE app
//
//  Created by Michael Thomas on 8/3/25.
//

import SwiftUI

struct PaymentConfirmationView: View {
    let gearItem: GearItem
    var onDismiss: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Payment Successful")
                .font(.title)
                .bold()
            Text("You purchased \(gearItem.name)")
            Text("Amount: $\(Double(gearItem.price)/100, specifier: "%.2f")")
            Button("Done") {
                onDismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
