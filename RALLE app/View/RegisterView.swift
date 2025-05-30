//
//  RegisterView.swift
//  RALLE app
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var session: SessionManager

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage = ""

    var onRegisterSuccess: () -> Void = {}

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    Spacer().frame(height: 40)

                    // Logo
                    Image("Ralle_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)

                    // Input Fields
                    VStack(spacing: 16) {
                        TextField("Username", text: $name)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))

                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))

                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }

                    // Error Message
                    if showError {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // Register Button
                    Button(action: handleRegister) {
                        Text("Register")
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
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                Button(action: {
                    session.showRegister = false
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                }
            )
        }
    }

    func handleRegister() {
        if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Please fill in all fields."
            showError = true
        } else if password != confirmPassword {
            errorMessage = "Passwords do not match."
            showError = true
        } else {
            showError = false
            onRegisterSuccess()
        }
    }
}

#Preview {
    RegisterView().environmentObject(SessionManager())
}
