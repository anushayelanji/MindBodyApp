import SwiftUI
import Combine

struct AppUser {
    var username: String
}

import SwiftUI

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var currentUser: AppUser?
    @Published var errorMessage: String?

    func login(withUserID userID: String) {
        print("Attempting login")
               
        self.currentUser = AppUser(username: userID)
        print("Login successful, currentUser updated")
        }
    
    func logout() {
        self.currentUser = nil
        UserDefaults.standard.removeObject(forKey: "userID")
    }
    
    func autoLogin() {
        if let storedUserID = UserDefaults.standard.string(forKey: "userID") {
            self.currentUser = AppUser(username: storedUserID)
        }
    }
}


struct LoginView: View {
    @State private var userID = ""
    @ObservedObject private var sessionManager = SessionManager.shared

    var body: some View {
        VStack {
            Text("Mind Body Connection")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30)
                .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))

            TextField("UserID", text: $userID)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal, 20)

            if let errorMessage = sessionManager.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }

            Button(action: {
                sessionManager.login(withUserID: userID)
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843161, green: 0.8078431487, blue: 0.8196078539, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.7529411911964417, blue: 0.9764705896377563, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .padding()
    }
}


 
 
