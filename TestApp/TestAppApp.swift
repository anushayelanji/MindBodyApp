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
            
            //Home tab
            NavigationView {
              UserEntriesView().environmentObject(manager)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            //Calender tab
            NavigationView {
                VStack {
                    ContentView()
                    Spacer() // This pushes the calendar to the top
                }
            }
            .navigationBarTitle("Title")
            .navigationBarTitleDisplayMode(.inline)
            .tabItem {
                Label("Calendar", systemImage: "calendar")
            }
            
            //Fitness view tab
            NavigationView {
              FitnessView().environmentObject(manager)
            }
            .tabItem {
                Label("Fitness", systemImage: "dumbbell")
            }
            
            
        }
    }
}



