//
//  PaymentViewModel.swift
//  RALLE app
//
//  Created by Michael Thomas on 7/23/25.
//
import SwiftUI
import Stripe
import StripePaymentSheet
import Foundation

class PaymentViewModel: ObservableObject {
    @Published var paymentSheet: PaymentSheet?
    func preparePaymentSheet(amount: Int) {
        //1. fetch client secret from backend
        guard let url = URL(string: "http://localhost:3001/api/payments/create-payment-intent") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(["amount": amount])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
            let result = try? JSONDecoder().decode(ClientSecretResponse.self, from: data) else {
                print("Failed to decode client secret")
                return
            }
            //2. Configure the payment sheet
            var configuration = PaymentSheet.Configuration()
            configuration.merchantDisplayName = "Ralle App"
            DispatchQueue.main.async {
                self.paymentSheet = PaymentSheet(paymentIntentClientSecret: result.clientSecret, configuration: configuration)
            }
        }.resume()
    }

    func presentPaymentSheet(controller: UIViewController) {
        paymentSheet?.present(from: controller) { paymentResult in
            switch paymentResult {
                case .completed:
                    print("Payment complete")
                case .canceled:
                    print("Payment canceled")
                case .failed(let error):
                    print("Payment failed: \(error.localizedDescription)")
            }
        }
    }
}
    struct ClientSecretResponse: Codable {
        let clientSecret: String
    }
