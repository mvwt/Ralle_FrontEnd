////
////  EventDetialView.swift
////  RALLE app
////
////  Created by Gavin Randolph on 5/29/25.
////
//
//import SwiftUI
//import EventKit
//
//struct EventDetailView: View {
//    let event: Event
//    @Environment(\.presentationMode) var presentationMode
//    
//    @State private var isRegistered = false
//    @State private var showCalendarAlert = false
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            Image("Ralle_header")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 200, height: 120)
//                .padding(.top)
//            
//            //            Text("\(event.title) - \(event.date)")
//            //                .font(.headline)
//            Text("\(event.title) - \(event.date, style: .date)")
//                .font(.headline)
//            Text("\(event.spotsAvailable) of \(event.capacity) spots available")
//                .font(.subheadline)
//            
//            if event.earlyAccess {
//                VStack(spacing: 8) {
//                    Text("Register Early (Tier 1 and 2 Members Only)")
//                    Text("Open Registration Begins June 6")
//                    Button("Notify Me When General Registration Opens") {}
//                        .font(.footnote)
//                        .foregroundColor(.blue)
//                }
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(10)
//                
//            } else {
//                // Button("Register") {  //  button is recreated using VStack with T/F logic based on isRegistered
//                // Handle registration logic here
//                VStack(spacing: 16) {
//                    Button(action: {
//                        registerForEvent()
//                    })
//                    {
//                        Text(isRegistered ? "Registered!" : "Register")
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(isRegistered ? Color.gray: Color.black)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                    .disabled(isRegistered)
//                    
//                    if isRegistered {
//                        VStack(spacing: 10) {
//                            Button("Add to iCal")
//                            {
//                                addToCalendar(event: event)
//                            }
//                            if let url = googleCalendarLink(event: event) {
//                                Link("Add to Google Calendar", destination: url)
//                            }
//                        }
//                        Button("Invite a Friend") {
//                            // Invite logic
//                        }
//                        .padding(.top)
//                    }
//                        .padding()
//                        .background(Color.gray.opacity(0.05))
//                        .cornerRadius(10)
//                }
//            }
//                .padding(.horizontal)
//        }
//        Spacer()
//        //        .frame(maxWidth: .infinity)
//        //        .padding()
//        //        .background(Color.black)
//        //        .foregroundColor(.white)
//        //        .cornerRadius(10)
//    }
//        .padding()
//}
//
//.navigationBarTitleDisplayMode(.inline)
//.navigationBarBackButtonHidden(true)
//.navigationBarItems(leading:
//                        Button(action: {
//    presentationMode.wrappedValue.dismiss()
//}) {
//    HStack {
//        Image(systemName: "chevron.left")
//        Text("All Events")
//    }
//    .foregroundColor(.black)
//}
//)
//            // Mark Functions
//            func registerForEvent() {
//                isRegistered = true
//            }
//            
//            func addToCalendar(event: Event) {
//                let store = EKEventStore()
//                store.requestAccess(to: .event) { granted, error in
//                    if granted {
//                        let ekEvent = EKEvent(eventStore: store)
//                        ekEvent.title = event.title
//                        ekEvent.startDate = event.date
//                        ekEvent.endDate = event.date
//                        do {
//                            try store.save(ekEvent, span: .thisEvent)
//                        } catch {
//                            print("Failed to save event to calendar: \(error.localizedDescription)")
//                        }
//                    }
//                }
//            }
//            func googleCalendarLink(event: Event) -> URL? {
//                let formatter = ISO8601DateFormatter()
//                formatter.timeZone = .current
//                let start = formatter.string(from: event.date)
//                    .replacingOccurrences(of: ":", with: "")
//                    .replacingOccurrences(of: "-", with: "")
//                let end = formatter.string(from: event.date)
//                    .replacingOccurrences(of: ":", with: "")
//                    .replacingOccurrences(of: "-", with: "")
//                
//                let urlString = "https://calendar.google.com/calendar/render?action=TEMPLATE&text=\(event.title)&dates=\(start)/\(end)&location=\(event.location)"
//                guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//                      let url = URL(string: encoded) else {
//                    return nil
//                }
//                
//                return url
//            }
//            //    #Preview {
//            //        EventDetailView(event: Event(title: "Event 3", date: Date(), location: "New York", spotsAvailable: 18, imageName: "bolt.fill", earlyAccess: false))
//            //    }
//            
//        struct EventDetailView_Previews: PreviewProvider {
//            static let sampleEvent = Event(
//                    title: "Event 3",
//                    date: Date(),
//                    location: "New York",
//                    spotsAvailable: 18,
//                    capacity: 35,
//                    imageName: "bolt.fill",
//                    earlyAccess: false
//                )
//            }
//            static var previews: some View {
//                EventDetailView(event: sampleEvent)
//            }
//
//
//  EventDetailView.swift
//  RALLE app
//
//  Created by Michael Thomas on 6/25/25.
//

import SwiftUI
import EventKit

struct EventDetailView: View {
    let event: Event
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isRegistered = false
    @State private var showCalendarAlert2 = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 24) {
                Image("Ralle_Header")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 120)
                    .padding(.top)
                
                Text("\(event.title) - \(event.date, style: .date)")
                    .font(.headline)
                
                Text("\(event.spotsAvailable) of \(event.capacity) spots available")
                    .font(.subheadline)
                
                if event.earlyAccess {
                    VStack(spacing: 8) {
                        Text("Register Early (Tier 1 and Tier 2 Members Only")
                        Text("Open Registration Begins on [Open Registration Date]")
                        Button("Notify Me When Open Registration Begins") {}
                            .font(.footnote)
                            .foregroundColor(.blue)
                        
                        
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                                    } else {
                                        VStack(spacing: 16) {
                                            Button(action: {
                                                isRegistered = true
                                            }) {
                                                Text(isRegistered ? "Registered: You're in!" : "Register Now")
                                                    .padding()
                                                    .frame(maxWidth: .infinity)
                                                    .background(isRegistered ? Color.gray : Color.black)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                            }
                                            .disabled(isRegistered)
                                            
                                            if isRegistered {
                                                VStack(spacing: 10) {
                                                    Button("Add to iCal") {
                                                        openInAppleCalendar(event: event)
                                                    }
                                                    
                                                    if let url = googleCalendarLink(event: event) {
                                                        Link("Add to Google Calendar", destination: url)
                                                    }
                                                    
                                                    Button("Invite a Friend") { // save for V2
                                                        // invite logic, share button where you can text someone
                                                    }
                                                    .padding(.top)
                                                }
                                            
                                                .padding()
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(10)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back to All Events")
                }
                .foregroundColor(.black)
            }
                                
            )
        }
    }
    
    // Functions
    
func addToCalendar(event: Event) {
    let store = EKEventStore()
    store.requestFullAccessToEvents { (granted, error) in
        if granted {
            let ekEvent = EKEvent(eventStore: store)
            ekEvent.title = event.title
            ekEvent.startDate = event.date
            ekEvent.endDate = event.date
            do {
                try store.save(ekEvent, span: .thisEvent)
            } catch {
                print("Failed to save event to calendar: \(error.localizedDescription)")
            }
        }
    }
}
func googleCalendarLink(event: Event) -> URL? {
    let formatter = ISO8601DateFormatter()
    formatter.timeZone = .current
    
    let start = formatter.string(from: event.date)
        .replacingOccurrences(of: ":", with: "")
        .replacingOccurrences(of: "-", with: "")
    let urlString = "https://calendar.google.com/calendar/render?action=TEMPLATE&text=\(event.title)&dates=\(start)/\(start)&details=\(event.location)&location=\(event.location)"
    
    guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let url = URL(string: encoded) else {
        return nil
    }
    return url
}
func openInAppleCalendar(event: Event) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd'T'HHmmssZ" // formatting date and time
    
    let startDate = dateFormatter.string(from: event.date)
    let endDate = dateFormatter.string(from: event.date)
    
    let icsString = """
    BEGIN: VCALENDAR
    VERSION: 2.0
    BEGIN: VEVENT
    SUMMARY:\(event.title)
    DTSTART:\(startDate)
    DTEND:\(endDate) 
    LOCATION:\(event.location)
    DESCRIPTION:\(event.title)
    END:VEVENT
    END: VCALENDAR
    """
    // DTSTART and DTEND think about time zones, this defaults to users location (best)
    // use case for hard coded time zones is someone is signing up for an event not in their city, rare
    
    let tempDir = FileManager.default.temporaryDirectory
    let fileURL = tempDir.appendingPathComponent("event.ics")
    
    do {
        try icsString.write(to: fileURL, atomically: true, encoding: .utf8)
        UIApplication.shared.open(fileURL)
    } catch {
        print("Failed to write .ics file: \(error.localizedDescription)")
    }
    print("ICS file saved at: \(fileURL.path)")
    
}

    
#Preview {
    NavigationView {
        EventDetailView(event: Event(
            title: "Event 3",
            date: Date(),
            location: "New York",
            spotsAvailable: 18,
            capacity: 35,
            imageName: "bolt.fill",
            earlyAccess: false
        ))
            
    }
}
