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
    
    @EnvironmentObject var manager: HealthManager
    
    @EnvironmentObject var sessionManager: SessionManager
    
    // Define dateFormatter as a static variable so it's only created once.
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        
        
        
        VStack {
            let userID = sessionManager.currentUser?.username
            
          Spacer()
            Text("Meal and Mood Insights").bold().frame(maxWidth: .infinity).foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843160629272, green: 0.8078431487083435, blue: 0.8196078538894653, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.7529411911964417, blue: 0.9764705896377563, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(20)
                //.padding()
            
            
            List(userEntries.data.filter {$0.name == userID}) { userModel in
                VStack(alignment: .leading) {
                    Text(userModel.name)
                        .font(.headline)
                    
                    Text("Date: \(userModel.date, formatter: Self.dateFormatter)")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    HStack{
                        Text("Breakfast: " + (userModel.breakfast ?? "Empty breakfast"))
                        Spacer()
                        Text("Calories: " + (userModel.cal_brek ?? "Empty")).italic()
                    }
                    
                    HStack{
                        Text("Lunch: " + (userModel.lunch ?? "Empty lunch"))
                        Spacer()
                        Text("Calories: " + (userModel.cal_lun ?? "Empty")).italic()
                    }
                    
                    HStack{
                        Text("Dinner: " + (userModel.dinner ?? "Empty dinner"))
                        Spacer()
                        Text("Calories: " + (userModel.cal_din ?? "Empty")).italic()
                    }
                    
                    HStack{
                        Text("Dessert: " + (userModel.dessert ?? "Empty dessert"))
                        Spacer()
                        Text("Calories: " + (userModel.cal_des ?? "Empty")).italic()
                    }
                    
                    Text("Morning Mood: " + (userModel.morningMood ?? "Empty mood"))
                    Text("Midday Mood: " + (userModel.middayMood ?? "Empty mood"))
                    Text("Night Mood: " + (userModel.nightMood ?? "Empty mood"))
                    
                    Spacer()
                   
               
                    // Recommendations based on heuristics
                    reccs1(for: userModel)
                    reccs2(for: userModel)
                    lifestylescore(for: userModel)
                    
                    
                    
                    Text("")
                }
                

                
                
            }
            
            
    
            VStack{
                Text("Fitness Insights for Today").bold().foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                VStack{
                    ForEach(Array(manager.activities.sorted(by: { $0.value.id < $1.value.id })), id: \.key) { item in
                        if let index = Array(manager.activities.values).firstIndex(where: { $0.id == item.value.id }) {
                            if index == 0 {
                                HStack{
                                    Text("Steps: " + item.value.amount)
                                   
                                }
                                
                                //Text("You have taken over 10000 steps today - keep up the good work.")
                               // Text("You have not taken enough steps today - try to hit 10000 tommorow!")
                            
//                                if item.value.amount == "23.186"{
//                                    Text("Calories")
//                                    Text(item.value.amount)
//                                }
                                
                                // Use firstAmount as needed
                            } else if index == 1 {
                                HStack{
                                    Text("Calories: " + item.value.amount)
                                  
                                }
                                
//                                if item.value.amount == "997"{
//                                    Text("Steps")
//                                    Text(item.value.amount)
//                                }
        
                                // Use secondAmount as needed
                            }
                        }
                    }
                }
            }.frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843160629272, green: 0.8078431487083435, blue: 0.8196078538894653, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.7529411911964417, blue: 0.9764705896377563, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(20)
                .padding()
            
            //Spacer()
            
        }.navigationTitle("Home")//.padding(.top, -30)
    }
    
    // Generate heuristic-based recommendations
    private func reccs1(for userModel: UserModel) -> some View {
        
        
    //Int(userModel.cal_des!)!
        // Attempt to safely unwrap and convert both cal_des and cal_lun to Int
        if let dessertCaloriesString = userModel.cal_des, let dessertCalories = Int(dessertCaloriesString),
           let lunchCaloriesString = userModel.cal_lun, let lunchCalories = Int(lunchCaloriesString),
           let dinnerCaloriesString = userModel.cal_din, let dinnerCalories = Int(dinnerCaloriesString),
           let breakCaloriesString = userModel.cal_brek, let breakCalories = Int(breakCaloriesString){
            
            if breakCalories + lunchCalories + dinnerCalories + dessertCalories < 2000{
                return Text("Consider intaking more calories. You have not met the 2000 calories goal for the day.")
                    .foregroundColor(.red)
            }
            else if dessertCalories > 300{
                return Text("Limit high-calorie desserts for better health.")
                    .foregroundColor(.red)
            }
            else if lunchCalories > 600 {
                return Text("Consider lighter options for lunch to balance your daily intake.")
                    .foregroundColor(.red)
            }
            else if dinnerCalories > 600 {
                return Text("Consider lighter options for dinner to balance your daily intake and feel better later at night.")
                    .foregroundColor(.red)
            }
            
           
        }
        // Default case if any of the unwrappings or conversions fail, or no conditions are met
        return Text("You have skipped a meal today, consider adding another meal.")
            .foregroundColor(.red)
        
       
    }
    
    
    
    private func reccs2(for userModel: UserModel) -> some View {
        if let dessertCaloriesString = userModel.cal_des, let dessertCalories = Int(dessertCaloriesString),
           let lunchCaloriesString = userModel.cal_lun, let lunchCalories = Int(lunchCaloriesString),
           let dinnerCaloriesString = userModel.cal_din, let dinnerCalories = Int(dinnerCaloriesString),
           let breakCaloriesString = userModel.cal_brek, let breakCalories = Int(breakCaloriesString){
    
            //sad to happy and > 2000
            if userModel.morningMood == "Sad" && userModel.nightMood == "Ecstatic" && (breakCalories + lunchCalories + dinnerCalories + dessertCalories > 2000){
                return Text("You're mood has improved significantly today - you have hit 2000 calories. Keep up the good work.")
                    .foregroundColor(.red)
            }
            //happy to sad and < 2000
            else if (userModel.morningMood == "Ecstatic" || userModel.morningMood == "Happy") && (userModel.nightMood == "Sad" || userModel.nightMood == "Neutral") && (breakCalories + lunchCalories + dinnerCalories + dessertCalories < 2000){
                return Text("You're mood has changed negatively today and you have not eaten enough - consider intaking more calories.")
                    .foregroundColor(.red)
            }
            
            

            
        }
        
        
        return Text("Keep up the good work.")
            .foregroundColor(.red)

        
    }
    
    
    private func lifestylescore(for userModel: UserModel) -> some View {
//        if let dessertCaloriesString = userModel.cal_des, let dessertCalories = Int(dessertCaloriesString),
//           let lunchCaloriesString = userModel.cal_lun, let lunchCalories = Int(lunchCaloriesString),
//           let dinnerCaloriesString = userModel.cal_din, let dinnerCalories = Int(dinnerCaloriesString),
//           let breakCaloriesString = userModel.cal_brek, let breakCalories = Int(breakCaloriesString){
//    
        
            
//            if userModel.morningMood == "Sad" && userModel.nightMood == "Ecstatic" && (breakCalories + lunchCalories + dinnerCalories + dessertCalories > 2000){
//                return Text("You're mood has improved significantly today - you have hit 2000 calories. Keep up the good work")
//            }
//            else if (userModel.morningMood == "Ecstatic" || userModel.morningMood == "Happy") && (userModel.nightMood == "Sad" || userModel.nightMood == "Neutral") && (breakCalories + lunchCalories + dinnerCalories + dessertCalories < 2000){
//                return Text("You're mood has changed negatively today and you have not eaten enough - consider intaking more calories")
//            }
        
            
        //}
        
        
        return  Text("Lifestyle Score: xx").bold()

        
    }
    
    
    
    
    
    
    
    
    
    
}
   

    





struct extra{
    
    //
    //        if Int(userModel.cal_brek!)! + Int(userModel.cal_lun!)! + Int(userModel.cal_din!)! + Int(userModel.cal_des!)! < 2000{
    //            return Text("Consider intaking more calories. You have not met the 2000 calories goal.")
    //        }
    //        if Int(userModel.cal_brek!)! + Int(userModel.cal_lun!)! + Int(userModel.cal_din!)! + Int(userModel.cal_des!)! < 2000 && (userModel.breakfast == nil || userModel.lunch == nil || userModel.dinner == nil){
    //            return Text("You have skipped mean and not met the 2000 calories goal. Consider eating another meal.")
    //        }
    
    
    
    //                    ForEach(manager.activities.sorted(by: { $0.value.id < $1.value.id}), id: \.key) { item in
    //                        Text(item.value.amount)
    //                        //ActivityCard(activity: item.value)
    //
    //                    }
    //
    //var firstAmount: Int? // Declare outside the loop
    //  var secondAmount: Int?
    //                    ForEach(Array(manager.activities.sorted(by: { $0.value.id < $1.value.id })), id: \.key) { item in
    //                        if let index = Array(manager.activities.values).firstIndex(where: { $0.id == item.value.id }) {
    //                            if index == 0 {
    //                                Text(item.value.amount)
    //                                // Use firstAmount as needed
    //                            } else if index == 1 {
    //                                Text(item.value.amount)
    //                                // Use secondAmount as needed
    //                            }
    //                        }
    //                    }
    //
    //
    //
    //                    if let firstAmount = firstAmount {
    //                        Text("\(firstAmount)") // Display firstAmount
    //                    }
    //                    if let secondAmount = secondAmount {
    //                        Text("\(secondAmount)") // Display firstAmount
    //                    }
    
    
    // You can add more recommendation conditions based on your requirements
    //return Text("") // Default return, an empty Text view
    
    
    
    
    
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
    
    
    //        let optionalString: String? = userModel.cal_des // Example optional string
    //        var integerValue = 0
    //        // Check if optionalString is nil or empty
    //        if let unwrappedString = optionalString, !unwrappedString.isEmpty {
    //            // Attempt to convert unwrappedString to an integer
    //            if integerValue == Int(unwrappedString) {
    //                // Successfully converted to integer
    //                print("Integer value:", integerValue)
    //            } else {
    //                // Handle case where string cannot be converted to integer
    //                print("Unable to convert to integer")
    //            }
    //        } else {
    //            // Optional string is nil or empty, set integer value to 0
    //            integerValue = 0
    //            print("Integer value:", integerValue)
    //        }
    //
    //        if integerValue > 300 {
    //                   return Text("Consider adding breakfast for a balanced diet.")
    //                       .foregroundColor(.red)
    //        }else{
    //            return Text("boo")
    //        }
    
    
    //        if let dessertCaloriesString = userModel.cal_des, let dessertCalories = Int(dessertCaloriesString), dessertCalories > 300 {
    //            // Now we know dessertCalories is safely unwrapped and converted to Int, and we can check its value
    //            return Text("Limit high-calorie desserts for better health.")
    //                .foregroundColor(.red)
    //        }
    //        // You can add more recommendation conditions based on your requirements
    //        return Text("") // Default return, an empty Text view
    //
    //
}
