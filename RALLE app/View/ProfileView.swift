//
//  ProfileView.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/26/25.
//

import SwiftUI

struct ProfileView: View {
    // Mock data – replace with actual user info later
    let userName = "Michael Thomas"
    let eventsCompleted = 4
    let membershipTier = "Tier 1"
    let nextEventName = "Urban Roots x Ralle"
    @State private var nextEventTime = Date().addingTimeInterval(5400) // 1.5 hours from now

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                // Profile Picture and Name
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 140, height: 140)

                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.black)
                    }

                    Text(userName)
                        .font(.title2)
                        .bold()
                }

                // Stats Section
                HStack(spacing: 20) {
                    statBox(title: "Events", value: "\(eventsCompleted)")
                    statBox(title: "Tier", value: membershipTier)
                    statBox(title: "Streak", value: "2 days")
                }
                .padding(.horizontal)

                // Next Event Info
                VStack(spacing: 10) {
                    Text("Next Event")
                        .font(.headline)
                        .underline()

                    Text(timeRemainingString(to: nextEventTime))
                        .font(.system(size: 28, weight: .medium, design: .monospaced))

                    Text(nextEventName)
                        .font(.subheadline)
                }
                .padding()
                .frame(maxWidth: 320)
                .background(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))

                // Opt-in Button
                Button(action: {
                    print("User opted in")
                }) {
                    Text("Click Here to Opt In")
                        .font(.subheadline)
                        .bold()
                        .frame(maxWidth: 320)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // Highlights or Achievements
                VStack(spacing: 12) {
                    Text("Your Highlights")
                        .font(.headline)
                        .padding(.top)

                    HStack(spacing: 16) {
                        highlightItem(icon: "flame.fill", title: "Weekly Streak")
                        highlightItem(icon: "heart.fill", title: "Favorite Event")
                        highlightItem(icon: "clock.fill", title: "Most Consistent")
                    }
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .foregroundColor(.black)
        .background(Color.white.ignoresSafeArea())
    }

    // Countdown formatter
    func timeRemainingString(to date: Date) -> String {
        let diff = max(Int(date.timeIntervalSinceNow), 0)
        let hours = diff / 3600
        let minutes = (diff % 3600) / 60
        let seconds = diff % 60
        return String(format: "%d:%02d:%02d", hours, minutes, seconds)
    }

    // Reusable stat box
    func statBox(title: String, value: String) -> some View {
        VStack {
            Text(value)
                .font(.headline)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 80, height: 60)
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.black))
    }

    // Reusable highlight icon
    func highlightItem(icon: String, title: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
            Text(title)
                .font(.caption)
        }
        .frame(width: 80, height: 80)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    ProfileView()
}
