//
//  TestAppApp.swift
//  TestApp
//
//  Created by John Chen on 2/13/24.
//

import SwiftUI


@main
    struct TestAppApp: App {
        //@StateObject var manager = HealthManager()
        var body: some Scene {
            
            WindowGroup {
                Content().environmentObject(SessionManager.shared)
                
            }
        }
    }
    
//navigation panel
struct TabbedView: View {
    @StateObject var manager = HealthManager()
    var body: some View {
        TabView {
            NavigationView {
                
              HomeView()
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
