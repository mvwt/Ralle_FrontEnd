//
//  LaunchScreenView.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @EnvironmentObject var session: SessionManager

    var body: some View {
        Group {
            if isActive {
                RootView()
            } else {
                ZStack {
                    Color.white.ignoresSafeArea()
                    Image("Ralle_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                .onAppear {
                    // Delay of 2.5 seconds before transitioning
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView().environmentObject(SessionManager())
}
