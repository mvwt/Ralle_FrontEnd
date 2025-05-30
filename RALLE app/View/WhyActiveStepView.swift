//
//  WhyActiveStep.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct WhyActiveStep: View {
    @EnvironmentObject var data: OnboardingData
    @State private var customText = ""
    var next: () -> Void

    let options = ["For my physical health", "For my mental health", "To connect with others", "To get outside daily"]

    var isInputValid: Bool {
        !data.activeReason.isEmpty || !customText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("Why do you lead an active lifestyle?")
                .font(.headline)
                .multilineTextAlignment(.center)

            ForEach(options, id: \.self) { reason in
                Button(action: {
                    if data.activeReason.contains(reason) {
                        data.activeReason.remove(reason)
                    } else {
                        data.activeReason.insert(reason)
                    }
                }) {
                    Text(reason)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                        .background(data.activeReason.contains(reason) ? Color.black.opacity(0.1) : Color.clear)
                }
                .foregroundColor(.black)
            }

            TextField("Other...", text: $customText)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))

            Button("Next") {
                data.customReason = customText
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
