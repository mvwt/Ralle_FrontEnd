//
//  LifestyleStep.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct LifestyleStep: View {
    @EnvironmentObject var data: OnboardingData
    var next: () -> Void
    let options = ["Active", "Resilient", "Intentional", "Experience Driven", "Community Conscious"]

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("Choose words that describe your lifestyle")
                .font(.headline)
                .multilineTextAlignment(.center)

            ForEach(options, id: \.self) { tag in
                Button(action: {
                    if data.lifestyleTags.contains(tag) {
                        data.lifestyleTags.remove(tag)
                    } else {
                        data.lifestyleTags.insert(tag)
                    }
                }) {
                    Text(tag)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                        .background(data.lifestyleTags.contains(tag) ? Color.black.opacity(0.1) : Color.clear)
                }
                .foregroundColor(.black)
            }

            Button("Next") {
                next()
            }
            .disabled(data.lifestyleTags.isEmpty)
            .opacity(data.lifestyleTags.isEmpty ? 0.5 : 1.0)
            .frame(maxWidth: .infinity)
            .padding()
            .background(data.lifestyleTags.isEmpty ? Color.gray : Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}
