//
//  RALLEapp.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/26/25.
//

import SwiftUI

@main
struct RALLEApp: App {
    @StateObject var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .environmentObject(session)
        }
    }
}



