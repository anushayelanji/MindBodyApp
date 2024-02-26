//
//  Reminder.swift
//  TestApp
//
//  Created by John Chen on 2/13/24.
//

//import SwiftUI
//
//struct ReminderView: View {
//    var date: Date
//
//    var formattedDate: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .long
//        dateFormatter.timeStyle = .none
//        return dateFormatter.string(from: date)
//    }
//
//    var body: some View {
//        Text("Reminders for \(formattedDate)")
//            .padding()
//    }
//}

import SwiftUI

struct FoodView: View {
    var date: Date
    //@State private var reminderTitle = ""
    @State private var foodBreakfast = ""
    @State private var foodLunch = ""
    @State private var foodDinner = ""
    @State private var foodDessert = ""
    @State private var food_cal_brek = ""
    @State private var food_cal_lun = ""
    @State private var food_cal_din = ""
    @State private var food_cal_des = ""
    //@State private var selectedMood: MoodTypes? = nil
    //@State private var selectedTime: MoodTimes? = nil
    @Binding var foods: [Food] // Assume this is passed from the ContentView
    
    
//    @State private var foodItems: [FoodItem] = []

    var body: some View {
        VStack {
//            TextField("Reminder Title", text: $reminderTitle)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                  .padding()
            Text("Food Eaten")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .padding()
            Text("")
            HStack{
                Text("Breakfast")
                TextField("", text: $foodBreakfast)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //.padding()
                Text("Calories")
                TextField("", text: $food_cal_brek)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Lunch")
                TextField("", text: $foodLunch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //.padding()
                Text("Calories")
                TextField("", text: $food_cal_lun)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Dinner")
                TextField("", text: $foodDinner)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //.padding()
                Text("Calories")
                TextField("", text: $food_cal_din)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Snack")
                TextField("", text: $foodDessert)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //.padding()
                Text("Calories")
                TextField("", text: $food_cal_des)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Text("")
            //Spacer()
                 // .lineSpacing(10.0)
            
//            TextField("foodDessert", text: $foodDessert)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                  .padding()
            
//            Picker("Time", selection: $selectedTime) {
//                //Text("None").tag(MoodType?.none)
//                ForEach(MoodTime.allCases) { mood in
//                    Text(mood.rawValue).tag(mood as MoodTimes?)
//                }
//            }.pickerStyle(SegmentedPickerStyle())
//                .padding()

//            Picker("Mood", selection: $selectedMood) {
//                //Text("None").tag(MoodType?.none)
//                ForEach(MoodTypes.allCases) { mood in
//                    Text(mood.rawValue).tag(mood as MoodTypes?)
//                }
//            
//            }
//            
            .pickerStyle(SegmentedPickerStyle())
            .padding(20)
            
            VStack{
                Button("Add Food") {
                    let newFood = Food(date: date, breakfast: foodBreakfast, lunch: foodLunch, dinner: foodDinner, dessert: foodDessert, cal_brek: food_cal_brek, cal_lun: food_cal_lun, cal_din: food_cal_din, cal_des: food_cal_des)
                    foods.append(newFood)
                    //reminderTitle = "" // Reset title for next input
                    //selectedTime = nil // Reset selected time
                    //selectedMood = nil // Reset selected mood
                    
                    
                    let userModel = UserModel(name: "Anusha", date: date, breakfast: foodBreakfast.isEmpty ? nil : foodBreakfast, lunch: foodLunch.isEmpty ? nil : foodLunch, dinner: foodDinner.isEmpty ? nil : foodDinner, dessert: foodDessert.isEmpty ? nil : foodDessert, cal_brek: food_cal_brek.isEmpty ? nil : food_cal_brek, cal_lun: food_cal_lun.isEmpty ? nil : food_cal_lun, cal_din: food_cal_din.isEmpty ? nil : food_cal_din, cal_des: food_cal_des.isEmpty ? nil : food_cal_des)
                    CoreDataManager.shared.updateUserEntry(name: userModel.name, date: userModel.date, userModel: userModel)
                    
                    foodBreakfast = ""
                    foodLunch = ""
                    foodDinner = ""
                    foodDessert = ""
                    food_cal_brek = ""
                    food_cal_lun = ""
                    food_cal_din = ""
                    food_cal_des = ""
                    
                    let userEntries = CoreDataManager.shared.fetchUserEntries()
                    for entry in userEntries {
                        print("Name: " + entry.name)
                        print("Date: \(entry.date)")
                        print("Breakfast: " + (entry.breakfast ?? "Empty breakfast") + " Calories: " + (entry.cal_brek ?? "Empty breakfast cals"))
                        print("Lunch: " + (entry.lunch ?? "Empty lunch") + " Calories: " + (entry.cal_lun ?? "Empty lunch cals"))
                        print("Dessert: " + (entry.dessert ?? "Empty dessert") + " Calories: " + (entry.cal_des ?? "Empty dessert cals"))
                        //print(entry.cal_des ?? "Empty dessert cals")
                        print("Morning Mood: " + (entry.morningMood ?? "Empty mood"))
                        print("Midday Mood: " + (entry.middayMood ?? "Empty mood"))
                        print("Night Mood: " + (entry.nightMood ?? "Empty mood"))
                        print("")
                        
                  
                        
                        let stringNumber1: String? = entry.cal_brek
                        guard let unwrappedString = stringNumber1, let intBrek = Int(unwrappedString) else {
                            //print("The string either is nil or cannot be converted to an Int.")
                            return
                        }
                        
                        let stringNumber2: String? = entry.cal_lun
                        guard let unwrappedString = stringNumber2, let intLun = Int(unwrappedString) else {
                            //print("The string either is nil or cannot be converted to an Int.")
                            return
                        }
                        
                        let stringNumber3: String? = entry.cal_din
                        guard let unwrappedString = stringNumber3, let intDin = Int(unwrappedString) else {
                            //print("The string either is nil or cannot be converted to an Int.")
                            return
                        }
                        
                        let stringNumber4: String? = entry.cal_des
                        guard let unwrappedString = stringNumber4, let intDes = Int(unwrappedString) else {
                            //print("The string either is nil or cannot be converted to an Int.")
                            return
                        }
//                        print("Converted Int value:", intValue)
                        

                       
                    
                        //print(entry)
                    }
                }
//                .padding()
//                .foregroundColor(.white)
//                .background(Color.cyan)
//                .cornerRadius(8)
                
                .padding()
                .foregroundColor(.white)
                .background(foodBreakfast == "" && foodLunch == "" && foodDinner == "" && foodDessert == "" ? Color.gray : Color.cyan)
                .cornerRadius(8)
                .disabled(foodBreakfast == "" && foodLunch == "" && foodDinner == "" && foodDessert == "" )
            }
            .padding()
            List(foods.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }) { food in
                VStack {
//                    if let mood = food.time {
//                        Text(mood.rawValue)
//                            
//                    }
                   
                    
                    //Spacer()
                    HStack{
                        if food.breakfast != ""{
                            Text("Breakfast").bold()
                            Spacer()
                            Text(food.breakfast)
                            Text("\(food.cal_brek)")
                                .italic()
                        }
                    }
                    HStack{
                        if food.lunch != ""{
                            Text("Lunch").bold()
                            Spacer()
                            Text(food.lunch)
                            Text(food.cal_lun)
                                .italic()
                        }
                    }
                    HStack{
                        if food.dinner != ""{
                            Text("Dinner").bold()
                            Spacer()
                            Text(food.dinner)
                            Text(food.cal_din)
                                .italic()
                        }
                    }
                    HStack{
                        if food.dessert != ""{
                            Text("Snack").bold()
                            Spacer()
                            Text(food.dessert)
                            Text(food.cal_des)
                                .italic()
                        }
                    }
//                    if let mood = food.lunch {
//                        Text(mood.rawValue)
//                            .foregroundColor(.gray)
//                            .italic()
//                    }
                    
//                    if let mood = reminder.mood {
//                        Text(mood.rawValue)
//                            .foregroundColor(.gray)
//                            .italic()
//                    }
                }
            }
        }
        .padding()
        //.navigationTitle("Add Mojod")
        .padding()
    }
    
//    func printFoodItems() {
//        for foodItem in foodItems {
//            if let foodItem = foodItem as? FoodItem {
//                print(foodItem.name ?? "")
//                print(foodItem.calories ?? 10)
//            }
//        }
//    }
        
}


struct Food: Identifiable, Hashable {
    var id = UUID()
    //ar title: String
    var date: Date
    //var time: MoodTime?
    //var mood: MoodTypes?
    var breakfast: String
    var lunch: String
    var dinner: String
    var dessert: String
    var cal_brek: String
    var cal_lun: String
    var cal_din: String
    var cal_des: String
}

//enum MoodTypes: String, CaseIterable, Identifiable {
//    case happy = "Happy"
//    case sad = "Sad"
//    case excited = "Excited"
//    case tired = "Tired"
//    
//    var id: String { self.rawValue }
//}

//enum MoodTimes: String, CaseIterable, Identifiable {
//    case morning = "Morning"
//    case midday = "Midday"
//    case night = "Night"
//   
//    var id: String { self.rawValue }
//}



