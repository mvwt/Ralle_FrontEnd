//
//  MembershipView.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI
import StoreKit

struct MembershipPlanView: View {
    let item: MembershipPlan
    let product: Product?
    let onPurchase: ((Product) -> Void)
    let isPurchased: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 16) {
                Image("Ralle_Header")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading) // try .center too
                    Text(item.price)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .bold()
                    Text(item.finePrint)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            if let product = product {
                if isPurchased {
                    Text("Subscribed")
                        .foregroundColor(.green)
                } else {
                    Button("Subscribe for \(item.price)") {
                        onPurchase(product)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                }
            } else {
                    Text("Product not available")
                        .foregroundColor(.red)
                }
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(item.features, id: \.self) { feature in
                        Text(" \(feature)")
                            .font(.footnote)
                    }
                }
                .padding(.horizontal)
            }
                .padding()
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black.opacity(0.2)))
                .padding(.horizontal)
        }
    }

struct MembershipPlan: Identifiable {
    let id = UUID()
    let title: String
    let price: String
    let description: String
    let finePrint: String
    let features: [String]
    let logoName: String
    let productID: String
//    let isPurchased: Bool
}

struct MembershipView: View {
    
    let plans: [MembershipPlan] = [
        MembershipPlan(
            title: "Tier 1 Community Member",
            price: "$9.99 / month",
            description: "Support RALLE in democratizing fitness. $10/month covers the cost for two people to RALLE together—every month.",
            finePrint: "Valid for 12 months",
            features: ["5–10% Gear Discounts", "RSVP Priority", "Referral Rewards"],
            logoName: "Ralle_Logo",
            productID: "com.ralleapp.ralleinsidertier1",
            //            isPurchased: false
        ),
        MembershipPlan(
            title: "Tier 2 Ralle Insider",
            price: "$19.99 / month",
            description: "Support RALLE. $20/month covers the cost for four people to RALLE together—every month.",
            finePrint: "Valid for 12 months",
            features: ["All Tier 1 Perks", "VIP Perks/Events", "15–20% Gear Discounts", "Random Exclusives"],
            logoName: "Ralle_Logo_Silver",
            productID: "com.ralleapp.ralleinsidertier2",
            //            isPurchased: false
        ),
        MembershipPlan(
            title: "Tier 2 Ralle Insider Yearly",
            price: "$199.99 / year",
            description: "Support RALLE. $10/month covers the cost for four people to RALLE together—every month.",
            finePrint: "Valid for 12 months",
            features: ["All Tier 1 Perks", "VIP Perks/Events", "15–20% Gear Discounts", "Random Exclusives"],
            logoName: "Ralle_Logo_Gold",
            productID: "com.ralleapp.ralleinsidertier2yearly",
            //            isPurchased: false
        )
    ]
    
    @State private var donationAmount: String = ""
    @State private var comment: String = ""
    //StoreKit vars
    @State private var products: [Product] = []
    @State private var purchasedProductIDs = Set<String>()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Image("Ralle_Header")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 120)
                    .padding(.top)
                
                Text("Choose your Membership Plan")
                    .font(.title2)
                    .bold()
                
                ForEach(plans) { plan in
                    MemberShipPlanWrapper(plan: plan)
//                    let matchedProduct = products.first { $0.id == plan.productID } // matching the plans to StoreKit products
//                    let isAlreadyPurchased = matchedProduct?.map {isPurchased($0)} ?? false
                    
//                    MembershipPlanView(
//                        item: plan,
//                        product: matchedProduct,
//                        onPurchase: { product in
//                            Task { await purchase(product)}
//                        },
//                        isPurchased: isAlreadyPurchased
//                    )
                }
                //                    VStack(spacing: 12) {
                //                        Image(plan.logoName)
                //                            .resizable()
                //                            .scaledToFit()
                //                            .frame(width: 50, height: 50)
                //
                //                        Text(plan.title)
                //                            .font(.headline)
                //
                //                        Text(plan.price)
                //                            .font(.subheadline)
                //                            .bold()
                //
                //                        Text(plan.description)
                //                            .font(.footnote)
                //                            .multilineTextAlignment(.center)
                //                            .padding(.horizontal)
                //
                //                        Text(plan.finePrint)
                //                            .font(.caption)
                //                            .foregroundColor(.gray)
                //
                //                        if let product = matchedProduct {
                //                            if isPurchased(product) {
                //                                Text("Suscribed")
                //                                    .foregroundColor(.green)
                //                            } else {
                //                                Button("Subscribe") {
                //                                    Task {
                //                                        await purchase(product)
                //                                    }
                //                                }
                //                                .frame(maxWidth: .infinity)
                //                                .padding()
                //                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                //                            }
                //                        } else {
                //                            Text("Product Not Available")
                //                                .foregroundColor(.red)
                //                        }
                //                        Divider()
                //                        // placeholder for features
                //                        VStack(alignment: .leading, spacing: 4) {
                //                            Text("Access Exclusive Content")
                //                            Text("Support the Community")
                //                            ForEach(plan.features, id: \ .self) { feature in
                //                                Text("• \(feature)")
                //                                    .font(.footnote)
                //                            }
                //                        }
                //                        .padding(.horizontal)
                //                    }
                //                    .padding()
                //                    .background(Color.white)
                //                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.2)))
                //                    .padding(.horizontal)
                //                }
                
//                VStack(alignment: .leading, spacing: 12) {
//                    Text("Give-What-You-Can Member")
//                        .font(.headline)
//                    
//                    Text("Give any amount you choose in support of RALLE Movements. We make movement free and accessible to all. These spaces are integral to the health & well-being of our communities.")
//                        .font(.footnote)
//                    
//                    Text("Amount: 20% lifetime RALLE Merch discount for a one-time contribution of $500 or more")
//                        .font(.caption)
//                        .italic()
//                    
//                    //                    TextField("$ Enter amount", text: $donationAmount)
//                    //                        .padding()
//                    //                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
//                    //
//                    //                    Text("Comment (optional)")
//                    //                        .font(.caption)
//                    //                    TextField("type here", text: $comment)
//                    //                        .padding()
//                    //                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
//                    
//                    ForEach(products.filter {$0.id.contains("gift") }) { product in
//                        VStack(alignment: .leading) {
//                            Text(product.displayName)
//                                .font(.subheadline)
//                                .bold()
//                            Text(product.description)
//                                .font(.caption)
//                            
//                            if isPurchased(product) {
//                                Text("Thank you for your gift")
//                                    .foregroundColor(.green)
//                            } else {
//                                Button("Give what you can") {
//                                    Task {
//                                        await purchase(product)
//                                    }
//                                }
//                            }
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.black)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
//                        
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.2)))
//                    .padding(.horizontal)
//                    Button("Restore Purchases") {
//                        Task {await restorePurchases()}
//                    }
//                    .foregroundColor(.blue)
//                    .padding(.bottom, 40)
//                }
            }
            .onAppear {
                Task {
                    await fetchProducts()
                    await restorePurchases()
                }
            }
            .background(Color.white.ignoresSafeArea())
        }
        
        
    }
    private func MemberShipPlanWrapper(plan: MembershipPlan) -> some View {
        if let product = products.first(where: {$0.id == plan.productID}) {
            MembershipPlanView(
                item: plan,
                product: product,
                onPurchase: { product in
                    Task { await purchase(product)}
                },
                isPurchased: isPurchased(product)
            )
        } else {
            MembershipPlanView(
                item: plan,
                product: nil,
                onPurchase: { _ in },
                isPurchased: false
            )
        }
    }
    
    func fetchProducts() async {
        let ids: Set<String> = [
            "com.ralleapp.ralleinsidertier1",
            "com.ralleapp.ralleinsidertier2",
            "com.ralleapp.ralleinsidertier2yearly",
            "com.ralleapp.give-what-you-can"
        ]
        do {
            products = try await Product.products(for: ids)
            print("fetched products: \(products.map { $0.id})")
        } catch {
            print("Failed to fetch StoreKit products: \(error)")
        }
    }
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                switch verification {
                case .verified(let transaction):
                    purchasedProductIDs.insert(transaction.productID)
                    await transaction.finish()
                case .unverified(_, let error):
                    print("Unverified purchase: \(error)")
                }
            case .userCancelled:
                print("User cancelled purchase")
            default:
                break
            }
            
        } catch {
            print("Purchase Failed: \(error)")
        }
    }
    func isPurchased(_ product: Product) -> Bool {
        purchasedProductIDs.contains(product.id)
    }
    func restorePurchases() async {
        try? await AppStore.sync()
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                purchasedProductIDs.insert(transaction.productID)
            }
        }
    }
}
#Preview {
    MembershipView()
}
