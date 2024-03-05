//
//  content.swift
//  TestApp
//
//  Created by John Chen on 2/29/24.
//

import SwiftUI

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
