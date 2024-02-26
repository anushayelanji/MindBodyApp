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
                TabbedView()
                
            }
        }
    }
    
//navigation panel
struct TabbedView: View {
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
            .tabItem {
                Label("Calendar", systemImage: "calendar")
            }
            NavigationView {
              Exercise()
            }
            .tabItem {
                Label("Exercise", systemImage: "dumbbell")
            }
            
        
            
        }
    }
}
