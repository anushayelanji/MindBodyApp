//
//  Home.swift
//  TestApp
//
//  John Chen, Anusha Yelanji, Kenny Chen, Vinny Carluccio
//

import SwiftUI


//    struct HomeView: View {
//        var body: some View {
//            //NavigationView {
//                VStack {
//                    NavigationLink(destination: ContentView()) {
//                        Text("Go to Calendar")
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(8)
//                    }
//                    .navigationTitle("Home")
//                }
//           // }
//        }
//    }
    




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
            
            
            
            
            
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home")
            .navigationTitle("Home")
    }
}
