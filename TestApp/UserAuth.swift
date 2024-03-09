import Foundation
import SwiftUI

class UserAuthManager: ObservableObject {
    static let shared = UserAuthManager()
    
    @Published var isLoggedIn: Bool = false
    
    private init() {}
    
    func login(username: String, password: String) {
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
