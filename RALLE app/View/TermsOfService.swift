//
//  TermsOfService.swift
//  RALLE app
//
//  Created by Michael Thomas on 6/27/25.
//

import SwiftUI


struct TermsOfService: View {
    var body: some View {
        Text("Terms of Service")
            .font(.headline)
        // more fomatting
        Text("Ralle is centered around accessibility, and our mission is to keep movement free. While we incurr costs organizing events and paying instructors, we fund that through community memberships and corporate partnerships. We use these questions in order to better understand our audience and tailor our events to their needs. They are also helpful in corporate pitches and marketing materials as we sell our brand to other organizations who can helo us keep movement free. All data is anonymized, and used for piching purposes only. We will never release your data for marketing reasons or otherwise.")
            .border(Color.gray)
            .background(Color.gray .opacity(0.3))
            .cornerRadius(10)
            .padding(30)
        // more formatting
    }
}
#Preview {
    TermsOfService()
}
