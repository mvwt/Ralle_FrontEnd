//
//  EventsView.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let location: String
    let spotsAvailable: Int
    let capacity: Int
    let imageName: String
    let earlyAccess: Bool
}

//struct DateFormatterManager {
//    static let shated: DateFormatter = {
//        let Formatter = DateFormatter()
//        Formatter.dateStyle = .medium
//        Formatter.timeStyle = .short
//        Formatter.locale = Locale.current
//        return Formatter
//        
//        
//    }()
//}

func customFormattedDate(_ date: Date, format: String) -> String { //used for dynamic formatting from admin panel or config file
    let Formatter = DateFormatter()
    Formatter.dateFormat = format
    return Formatter.string(from: date)
}

struct EventsView: View {

    let events: [Event] = [
        Event(title: "Event 1", date: Date(), location: "New York", spotsAvailable: 20, capacity: 20, imageName: "shoeprints.fill", earlyAccess: false),
        Event(title: "Event 2", date: Date(), location: "Minneapolis", spotsAvailable: 13, capacity: 20, imageName: "flame.fill", earlyAccess: true),
        Event(title: "Event 3", date: Date(), location: "New York", spotsAvailable: 18, capacity: 35, imageName: "bolt.fill", earlyAccess: true)
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Image("Ralle_Header")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 120)
                    .padding(.top)

                Text("Events")
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
                                Text(customFormattedDate(event.date, format: "MMM dd"))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(event.location)
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
#Preview {
    EventsView()
}
