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
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
  

    var filteredUserModels: [UserModel] {
        let filteredUserModels = userEntries.data.filter { userModel in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: userModel.date)
            return components.year == 2024 && components.month == 3 && components.day == 12
        }
        return filteredUserModels
    }
    
    var body: some View {
    
        VStack {
            let userID = sessionManager.currentUser?.username
            
            Spacer()
            Text("Meal and Mood Insights").bold().frame(width: 350).foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26)).padding(10)
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843160629272, green: 0.8078431487083435, blue: 0.8196078538894653, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.7529411911964417, blue: 0.9764705896377563, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(20)
            
            List(userEntries.data.filter {$0.name == userID}) { userModel in
                VStack(alignment: .leading) {
                    Text(userModel.name)
                        .font(.headline)
                    
                    Text("Date: \(userModel.date, formatter: Self.dateFormatter)")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    HStack{
                        Text("Breakfast: " + (userModel.breakfast ?? "n/a"))
                        Spacer()
                        Text("Calories: " + (userModel.cal_brek ?? "n/a")).italic()
                    }
                    
                    HStack{
                        Text("Lunch: " + (userModel.lunch ?? "n/a"))
                        Spacer()
                        Text("Calories: " + (userModel.cal_lun ?? "n/a")).italic()
                    }
                    
                    HStack{
                        Text("Dinner: " + (userModel.dinner ?? "n/a"))
                        Spacer()
                        Text("Calories: " + (userModel.cal_din ?? "n/a")).italic()
                    }
                    
                    HStack{
                        Text("Dessert: " + (userModel.dessert ?? "n/a"))
                        Spacer()
                        Text("Calories: " + (userModel.cal_des ?? "n/a")).italic()
                    }
                    
                    Text("Morning Mood: " + (userModel.morningMood ?? "n/a"))
                    Text("Midday Mood: " + (userModel.middayMood ?? "n/a"))
                    Text("Night Mood: " + (userModel.nightMood ?? "n/a"))
                    
                    Spacer()
                    
                    // Recommendations based on heuristics
                    if (userModel.dessert == "Drugs" || userModel.dinner == "Drugs" || userModel.lunch == "Drugs" || userModel.breakfast == "Drugs"){
                        Text("Drugs should not be consumed. Call 911 for help. Call 988 if you are suicidal.")
                            .foregroundColor(.red)
                        Text("Lifestyle score: 0/100")
                            .bold()
                    }
//                    else if(){
//                        reccs1(for: userModel)
//                        reccs2(for: userModel)
//                        reccs3(for: userModel)
//                        lifestylescore(for: userModel)
//                    }
                    
                    else{
                        reccs1(for: userModel)
                        reccs2(for: userModel)
                        reccs3(for: userModel)
                        lifestylescore(for: userModel)
                    }
                    
                    Text("")
                }
                
            
        }

            ZStack {
                VStack {
                    Spacer()
                    VStack {
                        Text("Fitness Insights for Today")
                            .bold().frame(width: 350)
                            .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26)).padding(10)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843160629272, green: 0.8078431487083435, blue: 0.8196078538894653, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.7529411911964417, blue: 0.9764705896377563, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)

                        ScrollView {
                            VStack {
                                ForEach(Array(manager.activities.sorted(by: { $0.value.id < $1.value.id })), id: \.key) { item in
                                    if let index = Array(manager.activities.values).firstIndex(where: { $0.id == item.value.id }) {
                                        if index == 0 {
                                            VStack {
                                                HStack{
                                                    Text("Steps: ").bold()
                                                    Text(item.value.amount)
                                                }
                                                
                                                let formattedString = item.value.amount
                                                if let intValue = formattedString.intValueFromFormattedString() {
                                                    
                                                    
                                                    ForEach(filteredUserModels) { userModel in
                                                        
                                                        if intValue > 10000 {
                                                            if (userModel.morningMood == "Sad" && userModel.nightMood == "Ecstatic"){
                                                                Text("You're mood has most likely improved today because of the amount of steps taken. Keep up the good work")
                                                            }else{
                                                                Text("You have reached a goal of 10k steps - keep up the good work.")
                                                                    .foregroundColor(.red)
                                                            }
                                                        } else {
                                                            if(userModel.morningMood == "Sad" || userModel.middayMood == "Sad" || userModel.morningMood == "Neutral" || userModel.middayMood == "Neutral"){
                                                                Text("You have logged unhappy moods, try taking a walk to improve your mood.")
                                                                    .foregroundColor(.red)
                                                            }
                                                            Text("You have not taken enough steps today - try to go on a walk tomorrow.")
                                                                .foregroundColor(.red)
                                                        }
                                                    
                                                    }
                                                    
                                                
                                                    
                                                    
                                                } else {
                                                    // Invalid formatted string
                                                    Text(" ")
                                                }
                                            }
                                        } else if index == 1 {
                                            VStack {
                                                
                                                HStack {
                                                    Text("Calories: ").bold()
                                                    Text(item.value.amount)
                                                }
                                             
                                                    let formattedString = item.value.amount
                                                    if let intValue = formattedString.intValueFromFormattedString() {
                                                        
                                                        //for today date
                                                        ForEach(filteredUserModels) { userModel in
                                                                    
                
                                                            if let dessertCaloriesString = userModel.cal_des, let dessertCalories = Int(dessertCaloriesString),
                                                               let lunchCaloriesString = userModel.cal_lun, let lunchCalories = Int(lunchCaloriesString),
                                                               let dinnerCaloriesString = userModel.cal_din, let dinnerCalories = Int(dinnerCaloriesString),
                                                               let breakCaloriesString = userModel.cal_brek, let breakCalories = Int(breakCaloriesString){
                                                                
                                                                let total = breakCalories + lunchCalories + dinnerCalories + dessertCalories
                                                                
                                                                Text("You burned " + String(intValue) + " calories out of the following calories eaten: " + String(total))
                                                                    .foregroundColor(.red)
                                                                
                                                                if intValue > 200 {
                                                                    Text("You have burned a lot of calories today - keep up the good work.")
                                                                        .foregroundColor(.red)
                                                                } else {
                                                                    Text("Add in a little more cardio to feel better tomorrow.")
                                                                        .foregroundColor(.red)
                                                                }
                                                                
                                                                
                                                            }
                                                        }
                                                        
                                                        
//                                                        if intValue > 200 {
//                                                            Text("You have burned a lot of calories today - keep up the good work.")
//                                                                .foregroundColor(.red)
//                                                        } else {
//                                                            Text("Add in a little more cardio to feel better tomorrow.")
//                                                                .foregroundColor(.red)
//                                                        }
                                                    } else {
                                                        // Invalid formatted string
                                                        Text(" ")
                                                    }
                                                }
                                            }
                                            
                                            
                                            
                                        
                                    }
                                }
                            }
                        }
                    }

                }
                .frame(height: UIScreen.main.bounds.height * 0.20)
                .padding(.bottom, 10)
            }.padding(6.5)
    
            
        }.navigationTitle("Home")
    }
  
    private func reccs1(for userModel: UserModel) -> some View {
       
        //unwrapping calories
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
            }else if breakCalories + lunchCalories + dinnerCalories + dessertCalories > 4000 {
                return Text("You have intaked over 4000 calories, consider eating a lighter meal next time.")
                    .foregroundColor(.red)
            }
            
           
        }
       
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
    
    private func reccs3(for userModel: UserModel)  -> some View{
        if let dessertCaloriesString = userModel.cal_des, let dessertCalories = Int(dessertCaloriesString),
           let lunchCaloriesString = userModel.cal_lun, let lunchCalories = Int(lunchCaloriesString),
           let dinnerCaloriesString = userModel.cal_din, let dinnerCalories = Int(dinnerCaloriesString),
           let breakCaloriesString = userModel.cal_brek, let breakCalories = Int(breakCaloriesString){
    
            if (userModel.dessert == "Coffee" || userModel.dessert == "Tea"){
                return Text("Limit caffeine consumption after 2pm - it can negatively impact sleep.")
                    .foregroundColor(.red)
            }
            
            
            

            
        }
        
        
        return Text("Keep up the good work.")
            .foregroundColor(.red)

        
    }
    
    
    private func lifestylescore(for userModel: UserModel) -> some View {
        var points = 0.0
//        if userModel.nightMood == "Sad"{
//            points += 1
//        }else if userModel.nightMood == "Neutral"{
//            points += 10
//        }else if userModel.nightMood == "Happy"{
//            points += 20
//        }
//        else if userModel.nightMood == "Ecstatic"{
//            points += 30
//        }
        
        if let dessertCaloriesString = userModel.cal_des, let dessertCalories = Int(dessertCaloriesString),
           let lunchCaloriesString = userModel.cal_lun, let lunchCalories = Int(lunchCaloriesString),
           let dinnerCaloriesString = userModel.cal_din, let dinnerCalories = Int(dinnerCaloriesString),
           let breakCaloriesString = userModel.cal_brek, let breakCalories = Int(breakCaloriesString){
            
            
            let total = breakCalories + lunchCalories + dinnerCalories + dessertCalories
            let totals = Double(total)
            let cons = (totals/2000.0)
            let one = cons * 100.0
            let two = one - 100.0
            let penal = 100.0 - two
            let three = penal/100
            let final = three * 70
            
            points += final
            
            
        }
    
        return  Text("Lifestyle Score: " + String(points) + "/100").bold()

        
    }
    

    
    
}



   
extension String {
    func intValueFromFormattedString() -> Int? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let number = numberFormatter.number(from: self) {
            return number.intValue
        }
        return nil
    }
}





//old code

//            VStack{
//                Text("Fitness Insights for Today").bold().foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
//                VStack{
//                    ForEach(Array(manager.activities.sorted(by: { $0.value.id < $1.value.id })), id: \.key) { item in
//                        if let index = Array(manager.activities.values).firstIndex(where: { $0.id == item.value.id }) {
//                            if index == 0 {
//                                VStack{
//                                    Text("Steps: " + item.value.amount)
//
//
//                                    let formattedString = item.value.amount
//                                    if let intValue = formattedString.intValueFromFormattedString() {
//                                        if intValue > 10000{
//                                            //Text("\(intValue)")
//                                            Text("You have reached a goal of 10k steps - keep up the good work.")
//                                        }
//                                        else{
//                                            Text("You have not taken enough steps today - try to go on a walk tommorow.")
//                                        }
//
//                                    } else {
//                                        //Invalid formatted string
//                                         Text(" ")
//                                    }
//
//                                }
//
//
//                            } else if index == 1 {
//                                VStack{
//                                    HStack{
//                                        Text("Calories: " + item.value.amount)
//                                    }
//                                    HStack{
//                                        let formattedString = item.value.amount
//                                        if let intValue = formattedString.intValueFromFormattedString() {
//                                            if intValue > 200{
//                                                //Text("\(intValue)")
//                                                Text("You have burned a lot of calories today - keep up the good work.")
//                                            }
//                                            else {
//                                                Text("Add in a little more cardio to feel better tommorow.")
//                                            }
//
//                                        } else {
//                                            //Invalid formatted string
//                                            Text(" ")
//                                        }
//                                    }
//                                }
//
//
//                            }
//                        }
//                    }
//                }
//            }.frame(maxWidth: .infinity)
//                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843160629272, green: 0.8078431487083435, blue: 0.8196078538894653, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.7529411911964417, blue: 0.9764705896377563, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                .cornerRadius(20)
//                .padding()
            
    

