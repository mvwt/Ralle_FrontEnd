//
//  ReferralStep.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct ReferralStep: View {
    @EnvironmentObject var data: OnboardingData
    var next: () -> Void

    @State private var selectedSource: String = ""
    @State private var customText: String = ""

    let options = ["Word of mouth", "Social media", "Online search"]

    var isInputValid: Bool {
        !selectedSource.isEmpty || !customText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("How did you hear about RALLE?")
                .font(.headline)
                .multilineTextAlignment(.center)

            ForEach(options, id: \.self) { source in
                Button(action: {
                    selectedSource = source
                    customText = ""
                }) {
                    Text(source)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                        .background(selectedSource == source ? Color.black.opacity(0.1) : Color.clear)
                }
                .foregroundColor(.black)
            }

            TextField("Other...", text: $customText)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .onTapGesture {
                    selectedSource = ""
                }

            Button("Next") {
                data.heardFrom = selectedSource.isEmpty ? customText : selectedSource
                next()
            }
            .disabled(!isInputValid)
            .opacity(isInputValid ? 1.0 : 0.5)
            .frame(maxWidth: .infinity)
            .padding()
            .background(isInputValid ? Color.black : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}
