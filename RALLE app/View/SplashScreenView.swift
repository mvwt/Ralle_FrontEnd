import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var session: SessionManager

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            Image("Ralle_Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 100)

            Text("Welcome to RALLE")
                .font(.title)

            VStack(spacing: 16) {
                Button("Log In") {
                    session.showLogin = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Register") {
                    session.showRegister = true
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
        .fullScreenCover(isPresented: Binding(get: {
            session.showLogin
        }, set: { session.showLogin = $0 })) {
            LoginView(onLoginSuccess: {
                session.isLoggedIn = true
                session.showLogin = false
            })
        }
        .fullScreenCover(isPresented: Binding(get: {
            session.showRegister
        }, set: { session.showRegister = $0 })) {
            RegisterView(onRegisterSuccess: {
                session.needsOnboarding = true
                session.showRegister = false
            })
        }
        .fullScreenCover(isPresented: Binding(get: {
            session.isLoggedIn && !session.showLogin && !session.showRegister && !session.needsOnboarding
        }, set: { _ in })) {
            ProfileView()
        }
        .fullScreenCover(isPresented: Binding(get: {
            session.needsOnboarding
        }, set: { session.needsOnboarding = $0 })) {
            OnboardingView(finish: {
                session.isLoggedIn = true
                session.needsOnboarding = false
            })
            .environmentObject(OnboardingData())
        }
    }
}
