//
//  UserEntries.swift
//  TestApp
//
//  Created by Anusha Yelanji on 2/26/24.
//

//import Foundation
//import SwiftUI
//
//struct UserEntries{
//    var data: [UserModel]{
//        
//        
//       return CoreDataManager.shared.fetchUserEntries()
//    }c
//}
//
//struct UserEntries : ObservableObject{
//    var data: [User] {
//        return CoreDataManager.shared.fetchUserEntries()
//    }
//}

import Foundation
import Combine
import SwiftUI

class UserEntries: ObservableObject {
    @Published var data: [UserModel] = []

    init() {
        self.fetchEntries()
    }

    private func fetchEntries() {
        let users = CoreDataManager.shared.fetchUserEntries() // Assuming this returns [User]
        // Convert [User] to [UserModel]
        self.data = users.map { user in
            // Convert each User to UserModel, adjusting for optional String values
            UserModel(
                name: user.name ?? "",
                date: user.date ?? Date(),
                morningMood: user.morningMood,
                middayMood: user.middayMood,
                nightMood: user.nightMood,
                breakfast: user.breakfast,
                lunch: user.lunch,
                dinner: user.dinner,
                dessert: user.dessert,
                cal_brek: user.cal_brek,
                cal_lun: user.cal_lun,
                cal_din: user.cal_din,
                cal_des: user.cal_des
            )
        }
    }
}

import SwiftUI

struct UserEntriesView: View {
    @ObservedObject var userEntries = UserEntries()

    // Define dateFormatter as a static variable so it's only created once.
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // Configure the formatter to your desired format
        formatter.dateStyle = .medium // This is an example; adjust as needed.
        formatter.timeStyle = .none
        // Optionally, set the locale, timezone, etc., if needed
        return formatter
    }()

    var body: some View {
        NavigationView {
            List(userEntries.data) { userModel in
                VStack(alignment: .leading) {
                    Text(userModel.name)
                        .font(.headline)
                    // Use the static dateFormatter to format the date
                    Text("Date: \(userModel.date, formatter: Self.dateFormatter)")
                        .font(.subheadline)
                }
            }
            .navigationBarTitle("User Entries")
        }
    }
}


