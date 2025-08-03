//
//  GearViewModel.swift
//  RALLE app
//
//  Created by Michael Thomas on 7/20/25.
//

import Foundation
import StripePaymentSheet
import Stripe

@MainActor
class GearViewModel: ObservableObject {
    @Published var gearItems: [GearItem] = []
    @Published var paymentSheet: PaymentSheet?
    @Published var isPresentingPaymentSheet = false
    
    func fetchGear() async {
        guard let url = URL(string: "http://localhost:3001/api/gear") else {
            print("Invalid URL")
            return }
        print("attempting to fetch gear items...")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let raw = String(data: data, encoding: .utf8) ?? "nil"
            print("Raw response string:", raw)
            let decoded = try JSONDecoder().decode([GearItem].self, from: data)
            DispatchQueue.main.async {
                  self.gearItems = decoded
              }
        } catch {
            print("Failed to decode gear items: \(error.localizedDescription)")
            
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .typeMismatch(let type, let context):
                    print("Type mismatch: \(type) – \(context.debugDescription)")
                    print("codingPath:", context.codingPath)
                case .valueNotFound(let type, let context):
                    print("Value not found: \(type) – \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    print("Key '\(key)' not found: \(context.debugDescription)")
                case .dataCorrupted(let context):
                    print("Data corrupted: \(context.debugDescription)")
                @unknown default:
                    print("Unknown decoding error")
                }
            }
        }
    }
    func placeOrder(userId: UUID, gearId: Int = 1, quantity: Int = 1 ) async {
        guard let url = URL(string: "https://localhost:3001/api/gear") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "userId": userId,
            "gearId": gearId,
            "quantity": quantity
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(ServerResponse.self, from: data)
            print("Order Response: \(decoded.message)")
        } catch {
            print("Failed to place order: \(error.localizedDescription)")
        }
    }
    struct ServerResponse: Codable {
        let message: String
    }
    
}
