//
//  BrandSupportStep.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct BrandSupportStep: View {
    @EnvironmentObject var data: OnboardingData
    var next: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Text("Do you support brands that align with your values?")
                .multilineTextAlignment(.center)
                .font(.headline)

            VStack(spacing: 16) {
                Button("Yes") {
                    data.supportsBrandValues = true
                    next()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .foregroundColor(.black)

                Button("No") {
                    data.supportsBrandValues = false
                    next()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .foregroundColor(.black)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}
