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

@MainActor
class PaymentViewModel: ObservableObject {
    @Published var paymentSheet: PaymentSheet?
    @Published var isPresentingPaymentSheet = false
    @Published var paymentSucceeded = false
    
    func preparePaymentSheet(amount: Int) async {
        //1. fetch client secret from backend
        guard let url = URL(string: "http://192.168.0.24:3001/api/payments/create-payment-intent") else {
            print("Invalid pauyment intent URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // was setValue before
        let body: [String: Any] = [
            "amount": amount
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        do {
            let(data, _) = try await URLSession.shared.data(for: request)
            print("Raw backend response", String(data: data, encoding: .utf8) ?? "nil")
            do {
                let decoded = try JSONDecoder().decode(PaymentIntentResponse.self, from: data)
                print("Decoded client secret: \(decoded.clientSecret)")
                
                var configuration = PaymentSheet.Configuration()
                configuration.merchantDisplayName = "Ralle App"
//                configuration.style = .automatic
                configuration.applePay = nil
                
                DispatchQueue.main.async {
                    self.paymentSheet = PaymentSheet(
                        paymentIntentClientSecret: decoded.clientSecret,
                        configuration: configuration
                    )
                }
            } catch {
                print("JSON Decoding failed: \(error)")
                if let fallback = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print("Fallback decoded JSON: \(fallback)")
                }
            }
        } catch {
            print("Network Error: \(error.localizedDescription)")
        }
    }
    func presentPaymentSheet(controller: UIViewController, item: GearItem) {
        guard let paymentSheet = paymentSheet else {
            print("Payment sheet is nil")
            return
        }
        isPresentingPaymentSheet = true
        paymentSheet.present(from: controller) { [weak self] paymentResult in
            DispatchQueue.main.async {
                self?.isPresentingPaymentSheet = false
                switch paymentResult {
                    case .completed:
                        print("Payment complete")
                        self?.paymentSucceeded = true
                    Task {
                        await self?.sendOrderToBackend(item: item, quantity: 1)
                    }
                    case .canceled:
                        print("Payment canceled")
                    case .failed(let error):
                        print("Payment failed: \(error.localizedDescription)")
                }
            }
        }
    }
    func sendOrderToBackend(item: GearItem, quantity: Int) async {
        guard let url = URL(string: "http://192.168.0.24:3001/api/gear") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let orderPayload: [String: Any] = [
            "userId": 1, //replace with real user ID logic
            "itemId": item.id,
            "quantity": quantity
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: orderPayload)
            let(_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                print("Order successfully recorded in backend")
            } else {
                print("Order creation failed")
            }
        } catch {
            print("Error sending order: \(error.localizedDescription)")
        }
    }
}
    struct PaymentIntentResponse: Codable {
        let clientSecret: String
        
        enum CodingKeys: String, CodingKey {
            case clientSecret = "clientSecret"
        }
    }
