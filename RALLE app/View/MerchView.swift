import SwiftUI

struct MerchItem: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let imageName: String
    let description: String
}

struct MerchView: View {
    let merchItems: [MerchItem] = [
        MerchItem(name: "RALLE Cap", price: "$25", imageName: "Ralle_Hat", description: "Lightweight cap for sunny runs.")
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
                        
                        Text("Shop")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.top)

                    ForEach(merchItems) { item in
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
                                    Text(item.price)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                            }

                            Button("Buy Now") {
                                // Handle buy action
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
                .padding(.bottom, 24)
            }
            .background(Color.white.ignoresSafeArea())
            .navigationBarHidden(true) // Hide the default title
        }
    }
}
