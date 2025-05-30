import SwiftUI

class OnboardingData: ObservableObject {
    @Published var city: String = ""
    @Published var lifestyleTags: Set<String> = []
    @Published var supportsBrandValues: Bool? = nil
    @Published var sustainabilityChoice: String = ""
    @Published var activeReason: Set<String> = []
    @Published var customReason: String = ""
    @Published var maxShoeBudget: Int = 100
    @Published var heardFrom: String = ""
}

