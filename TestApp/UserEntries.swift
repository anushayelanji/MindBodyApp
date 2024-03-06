//
//  UserEntries.swift
//  TestApp
//
//  Created by Anusha Yelanji on 2/26/24.
//


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
                name: user.name,
                date: user.date ,
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

struct UserEntriesView: View {
    @ObservedObject var userEntries = UserEntries()

    // Define dateFormatter as a static variable so it's only created once.
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {
        //NavigationView{
            VStack {
                List(userEntries.data) { userModel in
                    VStack(alignment: .leading) {
                        Text(userModel.name)
                            .font(.headline)
                        
                        Text("Date: \(userModel.date, formatter: Self.dateFormatter)")
                            .font(.subheadline)
                        
                        Text("Breakfast: " + (userModel.breakfast ?? "Empty breakfast"))
                        Text("Calories: " + (userModel.cal_brek ?? "Empty"))
                        
                        Text("Lunch: " + (userModel.lunch ?? "Empty lunch"))
                        Text("Calories: " + (userModel.cal_lun ?? "Empty"))
                        
                        Text("Dessert: " + (userModel.dessert ?? "Empty dessert"))
                        Text("Calories: " + (userModel.cal_des ?? "Empty"))
                        
                        Text("Morning Mood: " + (userModel.morningMood ?? "Empty mood"))
                        Text("Midday Mood: " + (userModel.middayMood ?? "Empty mood"))
                        Text("Night Mood: " + (userModel.nightMood ?? "Empty mood"))
                        
                        // Recommendations based on heuristics
                        generateRecommendations(for: userModel)
                        
                        
                        Text("")
                    }
                }
                
                
           // }.padding(.top, -30)
        //Spacer()
                VStack{
                    Text("")
                    Text("Lifestyle Score: xx").bold()
                    Text("")
                }
        }.padding(.top, -30)
    }

    // Generate heuristic-based recommendations
    private func generateRecommendations(for userModel: UserModel) -> some View {
        // Example recommendations based on meal composition
        if userModel.breakfast == nil {
            return Text("Consider adding breakfast for a balanced diet.")
                .foregroundColor(.red)
        } else if userModel.lunch == nil {
            return Text("Including a nutritious lunch can help maintain energy levels throughout the day.")
                .foregroundColor(.red)
        } else if userModel.dessert != nil && userModel.cal_des != nil && Int(userModel.cal_des!)! > 300 {
            return Text("Limit high-calorie desserts for better health.")
                .foregroundColor(.red)
        }
        // You can add more recommendation conditions based on your requirements
        return Text("") // Default return, an empty Text view
    }

    
}



    
//    private func generateRecommendations(for userEntries: [UserModel]) -> some View {
//        var recommendations: [String] = []
//
//        // Analyze data from multiple days
//        // Example: Check for consistency in meal composition across days
//        var hasBreakfast: Bool = false
//        var hasLunch: Bool = false
//        var hasHighCalDessert: Bool = false
//
//        for userModel in userEntries {
//            if userModel.breakfast != nil {
//                hasBreakfast = true
//            }
//            if userModel.lunch != nil {
//                hasLunch = true
//            }
//            if userModel.dessert != nil && userModel.cal_des != nil && Int(userModel.cal_des!)! > 300 {
//                hasHighCalDessert = true
//            }
//        }
//
//        // Generate recommendations based on aggregated data
//        if !hasBreakfast {
//            recommendations.append("Consider adding breakfast for a balanced diet.")
//        }
//        if !hasLunch {
//            recommendations.append("Including a nutritious lunch can help maintain energy levels throughout the day.")
//        }
//        if hasHighCalDessert {
//            recommendations.append("Limit high-calorie desserts for better health.")
//        }
//
//        // Create a view to display recommendations
//        return VStack(alignment: .leading) {
//            ForEach(recommendations, id: \.self) { recommendation in
//                Text(recommendation)
//                    .foregroundColor(.red)
//            }
//        }
//    }
//                             
//  
//
//}





//something else

//            VStack{
//                ZStack {
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(Color.white)
//                        .shadow(radius: 5)
//                        .frame(width: 350, height: 100) // Adjust size as needed
//
//                    Text("This is a text card")
//                        .font(.headline)
//                        .foregroundColor(.black)

//Card approach
        
//        var num1: String
//        let cardData = [
//            "Card Info \n 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd \n1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1",
//            "Carfhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1d 2",
//            "Carvfhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1fhfhhyfvyfkhvututd 1d 3",
//            "Card 4",
//            "Card 5",
//            num1]
//
//        NavigationView {
//           
//            VStack{
//                ScrollView {
//                   
//                        LazyVGrid(columns: [GridItem(.flexible())]) {
//                            ForEach(cardData, id: \.self) { card in
//                                CardView(text: card)
//                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                    .padding()
//                            }
//                        }
//                    }//.navigationBarTitle("Title", displayMode: .inline)
//                
//            }.padding(.top, -80)
//        }.navigationBarTitle("Home")
//        //padding(.bottom, 80)
//        
//        num1 = "dfghj"
//        
//        
//       
//    }
//
//}
//

//
//struct CardView: View {
//    var text: String
//    
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color(red: 0.714, green: 0.898, blue: 0.961))
//                .shadow(radius: 5)
//            
//            Text(text)
//                .font(.headline)
//                .foregroundColor(Color(red: 0.306, green: 0.322, blue: 0.329))
//                .padding()
//        }
//    }
//}


