//
//  UserAuth.swift
//  TestApp
//
//  Created by John Chen on 2/29/24.
//

import Foundation
import SwiftUI

class UserAuthManager: ObservableObject {
    static let shared = UserAuthManager()
    
    @Published var isLoggedIn: Bool = false
    
    private init() {} // Private initializer to ensure singleton usage
    
    func login(username: String, password: String) {
        // Perform login logic here
        // This is a placeholder logic; implement actual authentication here
        if username == "user" && password == "password" {
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }
    
    func logout() {
        self.isLoggedIn = false
    }
}


