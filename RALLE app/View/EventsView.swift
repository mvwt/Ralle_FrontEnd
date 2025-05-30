//
//  EventsView.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct EventsView: View {
    struct Event: Identifiable {
        let id = UUID()
        let title: String
        let date: String
        let spotsAvailable: Int
        let imageName: String
        let earlyAccess: Bool
    }

    let events: [Event] = [
        Event(title: "Event 1", date: "June 6", spotsAvailable: 20, imageName: "shoeprints.fill", earlyAccess: false),
        Event(title: "Event 2", date: "June 13", spotsAvailable: 13, imageName: "flame.fill", earlyAccess: true),
        Event(title: "Event 3", date: "June 20", spotsAvailable: 18, imageName: "bolt.fill", earlyAccess: true)
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Image("Ralle_Header")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 120)
                    .padding(.top)

                Text("NYC Events")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.3))

                List(events) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        HStack(spacing: 12) {
                            Image(systemName: event.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(.vertical, 8)

                            VStack(alignment: .leading) {
                                Text(event.title)
                                    .font(.headline)
                                Text(event.date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
