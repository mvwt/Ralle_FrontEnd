//
//  BudgetStep.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct BudgetStep: View {
    @EnvironmentObject var data: OnboardingData
    var next: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Text("What is the max you'd spend on daily running shoes?")
                .font(.headline)
                .multilineTextAlignment(.center)

            Slider(
                value: Binding(
                    get: {
                        Double(data.maxShoeBudget)
                    },
                    set: { newVal in
                        data.maxShoeBudget = Int(newVal)
                    }
                ),
                in: 50...300,
                step: 10
            )
            .padding()

            Text("$\(data.maxShoeBudget)")
                .font(.title2)

            Button("Next", action: next)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}
