//
//  TestAppApp.swift
//  TestApp
//
//  Created by John Chen on 2/13/24.
//

import SwiftUI


@main
struct TestAppApp: App {
    var body: some Scene {
        WindowGroup {
            Content().environmentObject(SessionManager.shared)
        }
    }
}

struct Content: View {
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        Group {
            if sessionManager.currentUser != nil {
                TabbedView()
            } else {
                LoginView()
            }
        }
    }
}
    
//Navigation panel
struct TabbedView: View {
    @StateObject var manager = HealthManager()
    var body: some View {
        TabView {
            NavigationView {
              UserEntriesView().environmentObject(manager)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            NavigationView {
                
                VStack {
                            ContentView()
                            Spacer() // This pushes the calendar to the top
                        }
          
                //ContentView()
            }
            .navigationBarTitle("Title")
            .navigationBarTitleDisplayMode(.inline)
           


            .tabItem {
                Label("Calendar", systemImage: "calendar")
            }
            NavigationView {
              FitnessView().environmentObject(manager)
            }
            .tabItem {
                Label("Fitness", systemImage: "dumbbell")
            }
            
        
            
        }
    }
}



