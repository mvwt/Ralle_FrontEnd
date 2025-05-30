//
//  SustainabilityStep.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct SustainabilityStep: View {
    @EnvironmentObject var data: OnboardingData
    var next: () -> Void
    let options = ["Yes", "Not necessarily", "No"]

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Text("Do you care about sustainability in your athletic gear?")
                .font(.headline)
                .multilineTextAlignment(.center)

            ForEach(options, id: \.self) { choice in
                Button(choice) {
                    data.sustainabilityChoice = choice
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
