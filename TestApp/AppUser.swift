//
//  AppUser.swift
//  TestApp
//
//  Created by John Chen on 2/29/24.
//

import SwiftUI
import Combine

struct AppUser {
    var username: String
    // Add other relevant fields
}

import SwiftUI

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var currentUser: AppUser?
    @Published var errorMessage: String?

    func login(withUserID userID: String) {
        print("Attempting login")
                // Simulate successful login
        self.currentUser = AppUser(username: userID)
        print("Login successful, currentUser updated")
        }
    
    func logout() {
        self.currentUser = nil
        UserDefaults.standard.removeObject(forKey: "userID")
    }
    
    // Optionally, a method to attempt automatic login based on stored userID
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
            TextField("UserID", text: $userID)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if let errorMessage = sessionManager.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button("Login") {
                sessionManager.login(withUserID: userID)
            }
            .padding()
        }
    }
}
