//
//  MainTabView.swift
//  RALLE app
//
//  Created by Gavin Randolph on 5/29/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            EventsView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Events")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            
            MembershipView()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Membership")
                }
            
                    GearView()
                        .tabItem {
                            Image(systemName: "bag")
                            Text("Gear")
                        }
                }
                .accentColor(.black) // black icons when selected
        }
    }
}
