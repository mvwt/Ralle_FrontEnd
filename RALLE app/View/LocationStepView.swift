//
//  LocationStep.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct LocationStep: View {
    @EnvironmentObject var data: OnboardingData
    let cities = ["NYC", "Minneapolis", "Boston"]
    var next: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Text("Choose Your City")
                .font(.headline)

            ForEach(cities, id: \.self) { city in
                Button(city) {
                    data.city = city
                    next()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .foregroundColor(.black)
            }

            Spacer()
        }.padding()
    }
}
