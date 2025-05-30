//
//  MembershipView.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct MembershipPlan: Identifiable {
    let id = UUID()
    let title: String
    let price: String
    let description: String
    let finePrint: String
    let features: [String]
    let logoName: String
}

struct MembershipView: View {
    let plans: [MembershipPlan] = [
        MembershipPlan(
            title: "Tier 1 Community Member",
            price: "$9.99 / month",
            description: "Support RALLE in democratizing fitness. $10/month covers the cost for two people to RALLE together—every month.",
            finePrint: "Valid for 12 months",
            features: ["5–10% Gear Discounts", "RSVP Priority", "Referral Rewards"],
            logoName: "Ralle_Logo"
        ),
        MembershipPlan(
            title: "Tier 2 Ralle Insider",
            price: "$19.99 / month",
            description: "Support RALLE. $20/month covers the cost for four people to RALLE together—every month.",
            finePrint: "Valid for 12 months",
            features: ["All Tier 1 Perks", "VIP Perks/Events", "15–20% Gear Discounts", "Random Exclusives"],
            logoName: "Ralle_Logo_Silver"
        ),
        MembershipPlan(
            title: "Tier 2 Ralle Insider Yearly",
            price: "$199.99 / year",
            description: "Support RALLE. $10/month covers the cost for four people to RALLE together—every month.",
            finePrint: "Valid for 12 months",
            features: ["All Tier 1 Perks", "VIP Perks/Events", "15–20% Gear Discounts", "Random Exclusives"],
            logoName: "Ralle_Logo_Gold"
        )
    ]

    @State private var donationAmount: String = ""
    @State private var comment: String = ""

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
                    VStack(spacing: 12) {
                        Image(plan.logoName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)

                        Text(plan.title)
                            .font(.headline)

                        Text(plan.price)
                            .font(.subheadline)
                            .bold()

                        Text(plan.description)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Text(plan.finePrint)
                            .font(.caption)
                            .foregroundColor(.gray)

                        Button("Select") {
                            // Select action
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))

                        Divider()

                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(plan.features, id: \ .self) { feature in
                                Text("• \(feature)")
                                    .font(.footnote)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.2)))
                    .padding(.horizontal)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Give-What-You-Can Member")
                        .font(.headline)

                    Text("Give any amount you choose in support of RALLE Movements. We make movement free and accessible to all. These spaces are integral to the health & well-being of our communities.")
                        .font(.footnote)
                    
                    Text("Amount: 20% lifetime RALLE Merch discount for a one-time contribution of $500 or more")

                        .font(.caption)
                        .italic()

                    TextField("$ Enter amount", text: $donationAmount)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black))

                    Text("Comment (optional)")
                        .font(.caption)
                    TextField("type here", text: $comment)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black))

                    Button("Help Keep Movement Free") {
                        // Handle donation action
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.2)))
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
}
