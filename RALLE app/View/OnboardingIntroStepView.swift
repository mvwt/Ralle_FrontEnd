//
//  OnboardingIntroStep.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct OnboardingIntroStep: View {
    var next: () -> Void

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            Image("Ralle_Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)

            Text("We just need to ask a few quick questions.")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Let's Get Started", action: next)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal, 40)

            Spacer()
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
    }
}
