import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionManager

    @State private var email = ""
    @State private var password = ""
    @State private var isSecure = true
    @State private var showError = false

    var onLoginSuccess: (() -> Void)? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Spacer().frame(height: 40)

                    // Logo
                    Image("Ralle_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)

                    // Input Fields
                    VStack(spacing: 20) {
                        TextField("Email", text: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))

                        ZStack(alignment: .trailing) {
                            Group {
                                if isSecure {
                                    SecureField("Password", text: $password)
                                } else {
                                    TextField("Password", text: $password)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))

                            Button(action: {
                                isSecure.toggle()
                            }) {
                                Image(systemName: isSecure ? "eye.slash" : "eye")
                                    .padding(.trailing)
                                    .foregroundColor(.gray)
                            }
                        }
                    }

                    if showError {
                        Text("Please enter both email and password.")
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Login Button
                    Button(action: handleLogin) {
                        Text("Log In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Spacer().frame(height: 50)
                }
                .padding()
            }
            .background(Color.white.ignoresSafeArea(.keyboard))
            .navigationTitle("Log In")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                Button(action: {
                    session.showLogin = false
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                }
            )
        }
    }

    func handleLogin() {
        if email.isEmpty || password.isEmpty {
            showError = true
        } else {
            showError = false
            print("Logging in with \(email)")
            onLoginSuccess?()
        }
    }
}
