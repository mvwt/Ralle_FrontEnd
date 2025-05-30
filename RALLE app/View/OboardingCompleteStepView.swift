import SwiftUI

struct OnboardingCompleteStep: View {
    var finish: () -> Void

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            Image("Ralle_Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)

            Text("Thanks for sharing! You're all set.")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Continue") {
                finish()
            }
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
