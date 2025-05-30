//
//  EventDetialView.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct EventDetailView: View {
    let event: EventsView.Event
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 24) {
            Image("Ralle_Header")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 120)
                .padding(.top)

            Text("\(event.title) - \(event.date)")
                .font(.headline)

            Text("\(event.spotsAvailable) of 20 spots available")
                .font(.subheadline)

            if event.earlyAccess {
                VStack(spacing: 8) {
                    Text("Register Early (Tier 1 and 2 Members Only)")
                    Text("Open Registration Begins June 6")
                    Button("Notify Me When General Registration Opens") {}
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
            } else {
                Button("Register") {
                    // Handle registration logic here
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            Button("Invite a Friend") {
                // Invite logic
            }
            .padding(.top)

            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("All Events")
                }
                .foregroundColor(.black)
            }
        )
    }
}
