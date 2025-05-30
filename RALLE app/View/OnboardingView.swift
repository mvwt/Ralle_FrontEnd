import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var data: OnboardingData
    let finish: () -> Void
    @State private var step: Int = 0

    var body: some View {
        switch step {
        case 0:
            OnboardingIntroStep(next: goToNext)
        case 1:
            LifestyleStep(next: goToNext)
        case 2:
            BrandSupportStep(next: goToNext)
        case 3:
            SustainabilityStep(next: goToNext)
        case 4:
            WhyActiveStep(next: goToNext)
        case 5:
            BudgetStep(next: goToNext)
        case 6:
            ReferralStep(next: goToNext)
        case 7:
            LocationStep(next: goToNext)
        case 8:
            OnboardingCompleteStep(finish: finish)
        default:
            Text("Onboarding complete.")
        }
    }

    private func goToNext() {
        step += 1
    }
}
