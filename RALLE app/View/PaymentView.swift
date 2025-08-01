//
//  PaymetView.swift
//  RALLE app
//
//  Created by Michael Thomas on 7/23/25.
//

import SwiftUI
import Stripe
import StripePaymentSheet
//
//struct PaymentView: View {
//    @State private var paymentSucceeded = false
//    @State private var paymentError: String?
//    @State private var clientSecret: String?
//    
//    var body: some View {
//        VStack {
//            if let clientSecret = clientSecret {
//                PaymentSheet.PaymentButton(paymentIntentClientSecret: clientSecret) {
//                    paymentSucceeded = true
//                }
//            } else {
//                Text("Loading payment...")
//            }
//            if paymentSucceeded {
//                Text("Payment Successful!")
//            }
//            
//            if let error = paymentError {
//                Text("Error: \(error)")
//                    .foregroundColor(.red)
//            }
//        }
//        .onAppear {
//            fetchClientSecret()
//        }
//    }
//    func fetchClientSecret() {
//          guard let url = URL(string: "http://localhost:3001/api/payments/create-payment-intent") else { return }
//          var request = URLRequest(url: url)
//          request.httpMethod = "POST"
//          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//          let body: [String: Any] = ["amount": 4500] // amount in cents, e.g. $45.00
//          request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//
//          URLSession.shared.dataTask(with: request) { data, response, error in
//              if let data = data,
//                 let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
//                 let clientSecret = json["clientSecret"] as? String {
//                  DispatchQueue.main.async {
//                      self.clientSecret = clientSecret
//                  }
//              } else {
//                  DispatchQueue.main.async {
//                      self.paymentError = "Failed to get client secret"
//                  }
//              }
//          }.resume()
//      }
//}
//func fetchClientSecret() {
//    guard let url = URL(string: "http://localhost:3001/api/payments/create-payment-intent") else { return }
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    
//    let body: [String: Any] = ["amount": 4500] // amount in cents, so it is $45.00
//    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//    
//    URLSession.shared.dataTask(with: request) { data, response, error, in
//        if let data = data,
//        let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
//        let clientSecret = json["clientSecret"] as? String {
//            DispatcQueue.main.async {
//                self.clientSecret = clientSecret
//            }
//        } else {
//            DispatchQueue.main.async {
//                self.paymentError = "Failed to obtain client secret"
//            }
//        }
//    }.resume()
//
//}

//struct PaymentView: View {
//    @State private var paymentSucceeded = false
//    @State private var paymentError: String?
//    @State private var clientSecret: String?
//
//    var body: some View {
//        VStack {
//            if let clientSecret = clientSecret {
//                PaymentSheet.PaymentButton(paymentIntentClientSecret: clientSecret) {
//                    paymentSucceeded = true
//                }
//            } else {
//                Text("Loading payment...")
//            }
//
//            if paymentSucceeded {
//                Text("✅ Payment successful!")
//            }
//
//            if let error = paymentError {
//                Text("❌ \(error)")
//                    .foregroundColor(.red)
//            }
//        }
//        .onAppear {
//            fetchClientSecret()
//        }
//    }
//
//    func fetchClientSecret() {
//        guard let url = URL(string: "http://localhost:3001/api/payments/create-payment-intent") else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let body: [String: Any] = ["amount": 4500] // amount in cents, e.g. $45.00
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data,
//               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
//               let clientSecret = json["clientSecret"] as? String {
//                DispatchQueue.main.async {
//                    self.clientSecret = clientSecret
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.paymentError = "Failed to get client secret"
//                }
//            }
//        }.resume()
//    }
//}
struct PaymentView: View {
    let gearItem: GearItem
    @StateObject var viewModel = PaymentViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Buy Ralle Cap - $45")
                .font(.title)
            Button("Pay With Card") {
                viewModel.preparePaymentSheet(amount: gearItem.price) // in cents
            }
            .onAppear {
                viewModel.preparePaymentSheet(amount: gearItem.price)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Complete Payment") {
                if let rootVC = UIApplication.shared.connectedScenes
                    .compactMap ({ $0 as? UIWindowScene })
                    .first?.windows
                    .first?.rootViewController {
                        viewModel.presentPaymentSheet(controller: rootVC)
                    }
            }
        }
    }
}
