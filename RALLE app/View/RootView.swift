import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: SessionManager
    @StateObject var onboardingData = OnboardingData()

    var body: some View {
        if session.isLoggedIn {
            MainTabView()
                .environmentObject(session)
        } else if session.showLogin {
            LoginView(onLoginSuccess: {
                session.isLoggedIn = true
                session.showLogin = false
            })
            .environmentObject(session)
        } else if session.showRegister {
            RegisterView(onRegisterSuccess: {
                session.needsOnboarding = true
                session.showRegister = false
            })
            .environmentObject(session)
        } else if session.needsOnboarding {
            OnboardingView(finish: {
                session.isLoggedIn = true
                session.needsOnboarding = false
            })
            .environmentObject(onboardingData)
            .environmentObject(session)
        } else {
            SplashScreenView()
                .environmentObject(session)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(SessionManager())
}
