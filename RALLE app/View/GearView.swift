import SwiftUI
import StoreKit
import Stripe
import StripePaymentSheet
import PassKit

struct GearView: View {
    @StateObject private var gearViewModel = GearViewModel()
    @StateObject private var paymentViewModel = PaymentViewModel()
    
    @State private var isLoading = false
    @State private var isPresentingPaymentSheet = false
    @State private var selectedItem: GearItem?
    
    let gearItems: [GearItem] = [
        GearItem(id: 1, name: "RALLE Cap", price: 45, imageName: "Ralle_Hat", description: "For movement, lifestyle, and all the moments in between")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Image("Ralle_Header")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 120)
                        
                        Text("Gear")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.top)
                    if gearViewModel.gearItems.isEmpty {
                        Text("no gear available...")
                    } else {
                        ForEach(gearViewModel.gearItems) { item in // adding viewModel gets backend involved
                            GearItemView(
                                item: item,
                                gearViewModel: gearViewModel,
                                paymentViewModel: paymentViewModel)
                        }
                    }

                }
                .padding(.bottom, 24)
            }
            .onAppear {
                print("GearView appeared!")
                Task {
                    await gearViewModel.fetchGear()
                }
            }
            .background(Color.white.ignoresSafeArea())
            .navigationBarHidden(true) // Hide the default title
        }
    }
}


struct GearItemView: View {
    let item: GearItem
    @ObservedObject var gearViewModel: GearViewModel
    @ObservedObject var paymentViewModel: PaymentViewModel
    
//    @StateObject private var paymentViewModel = PaymentViewModel()
//    @ObservedObject var viewModel: GearViewModel
    @State private var isShowingPaymentSheet = false
    @State private var isPreparingPaymentSheet = false
    @State private var paymentSheet: PaymentSheet? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 16) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(String(format: "$%.2f", Double(item.price)/100.0))
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
            }

            Button(action: {
                isPreparingPaymentSheet = true
                paymentViewModel.preparePaymentSheet(amount: item.price)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.paymentSheet = paymentViewModel.paymentSheet
                    self.isPreparingPaymentSheet = false
                    self.isShowingPaymentSheet = true
                }
            }) {
                if isPreparingPaymentSheet {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                } else {
                    Text("Buy Now")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .disabled(isPreparingPaymentSheet)
        }
        .padding()
        .background(Color.white)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black.opacity(0.2)))
        .padding(.horizontal)
        .paymentSheet(
            isPresented: $isShowingPaymentSheet,
            paymentSheet: paymentSheet ?? <#default value#>
        ) { result in
            switch result {
            case .completed:
                print("✅ Payment completed successfully!")
                // Optionally trigger placeOrder(...) here
            case .canceled:
                print("⚠️ Payment canceled")
            case .failed(let error):
                print("❌ Payment failed: \(error.localizedDescription)")
            }
        }
    }
}

//struct GearItemView: View {
//    let item: GearItem
//    @ObservedObject var viewModel: GearViewModel
//    @State private var isShowingPaymentSheet = false
//    @State private var isPreparingPaymentSheet = false
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            HStack(alignment: .top, spacing: 16) {
//                Image(item.imageName)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 80, height: 80)
//                    .cornerRadius(12)
//                
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(item.name)
//                        .font(.headline)
//                    Text(item.description)
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                    Text(String(format: "$%.2f", Double(item.price)/100.0))
//                        .font(.subheadline)
//                        .foregroundColor(.black)
//                        
//                }
//            }
////            NavigationLink(destination: PaymentView(gearItem: item)) {
//            Button(action: {
//                isPreparingPaymentSheet = true
//                Task {
//                    await viewModel.preparePaymentSheet(for: item)
//                    isShowingPaymentSheet = true
//                    isShowingPaymentSheet = true
//                }
//            }) {
//                if isPreparingPaymentSheet {
//                    ProgressView()
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.gray)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                } else {
//                    Text("Buy Now")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.black)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            }
//            .disabled(isPreparingPaymentSheet)
////                    let testUserId = UUID(uuidString: "00000000-0000-0000-0000-000000000001")!
////                    Task {
////                        await viewModel.preparePaymentSheet(for: item)
////                    }
////                    placeOrder(userId: testUserId, gearId: item.id, quantity: 1)
////                }
////                .frame(maxWidth: .infinity)
////                .padding()
////                .background(Color.black)
////                .foregroundColor(.white)
////                .cornerRadius(10)
////            }
//        }
//        .padding()
//        .background(Color.white)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black.opacity(0.2)))
//        .padding(.horizontal)
//        .paymentSheet(
//            isPresented: $isShowingPaymentSheet,
//            paymentSheet: viewModel.paymentSheet
//        ) { result in
//            switch result {
//            case .completed:
//                print("Payment completed successfully!")
//                // optional to trigger placeOrder here
//            case .canceled:
//                print("Payment Canceled")
//            case .failed(let error):
//                print("Payment failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}

func placeOrder(userId: UUID, gearId: Int = 1, quantity: Int = 1 ) {
    guard let url = URL(string: "https://192.168.0.24:3001/api/gear") else {
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
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Request failed: \(error.localizedDescription)")
            return
        }
        guard let data = data else {
            print("No data in response")
            return
        }
        if let decoded = try? JSONDecoder().decode(ServerResponse.self, from: data) {
            print("✅ Order Response: \(decoded.message)")
        } else {
                print("❌ Failed to decode server response")
            }
            
        }.resume()
        
    }
func fetchClientSecret(for item: GearItem) async -> String? {
    print("fetching client secret...")
    guard let url = URL(string: "https://192.168.0.24:3001/create-payment-intent") else { return nil }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body = ["amount": item.price] // price is already in cents (integer, 4500)
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        if let result = try? JSONDecoder().decode([String: String].self, from: data),
           let clientSecret = result["clientSecret"] {
            return clientSecret
        } else {
            print("Could not decode client secret")
        }
    } catch {
        print("Network error: \(error.localizedDescription)")
    }
    return nil
}
func startApplePayCheckout(for item: GearItem) async {
    guard let clientSecret = await fetchClientSecret(for: item) else {
        print("Failed to get client secret from backend")
        return
    }
    
    var config = PaymentSheet.Configuration()
    config.merchantDisplayName = "Ralle Gear"
    config.applePay = .init(
        merchantId: "merchant.com.ralleapp", // create in Apple Dev Portal
        merchantCountryCode: "US"
    )
    config.style = .automatic // Light/Dark theme auto
    config.returnURL = "ralleapp://stripe-redirect" // optional
    
    let paymentSheet = PaymentSheet(paymentIntentClientSecret: clientSecret, configuration: config)

    await MainActor.run {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
           let rootVC = keyWindow.rootViewController {
            
            paymentSheet.present(from: rootVC) { result in
                switch result {
                case .completed:
                    print("✅ Gear Purchase Successful")
                case .canceled:
                    print("⚠️ User Canceled")
                case .failed(let error):
                    print("❌ Payment Failed: \(error.localizedDescription)")
                }
            }

        } else {
            print("❌ Could not find root view controller")
        }
    }
}

struct ServerResponse: Codable {
    let message: String
}


//#Preview {
//    GearView()
//}
