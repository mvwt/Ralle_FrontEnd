//
//  SessionManager.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var needsOnboarding: Bool = false
    @Published var showLogin: Bool = false
    @Published var showRegister: Bool = false
}
