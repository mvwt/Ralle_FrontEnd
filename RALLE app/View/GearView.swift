import SwiftUI

struct GearItem: Identifiable {
    let id: Int
    let name: String
    let price: String
    let imageName: String
    let description: String
}
struct GearItemView: View {
    let item: GearItem
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 16) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.imageName)
                        .font(.headline)
                    Text(item.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(item.price)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        
                }
            }
            Button("Buy Now") {
                let testUserId = UUID(uuidString: "00000000-0000-0000-0000-000000000001")!
                placeOrder(userId: testUserId, gearId: item.id, quantity: 1)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black.opacity(0.2)))
        .padding(.horizontal)
    }
}
struct GearView: View {
    let gearItems: [GearItem] = [
        GearItem(id: 1, name: "RALLE Cap", price: "$45", imageName: "Ralle_Hat", description: "For movement, lifestyle, and all the moments in between")
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

                    ForEach(gearItems) { item in
                        GearItemView(item: item)
                    }
                }
                .padding(.bottom, 24)
            }
            .background(Color.white.ignoresSafeArea())
            .navigationBarHidden(true) // Hide the default title
        }
    }
}

func placeOrder(userId: UUID, gearId: Int = 1, quantity: Int = 1 ) {
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
    struct ServerResponse: Codable {
        let message: String
    }


