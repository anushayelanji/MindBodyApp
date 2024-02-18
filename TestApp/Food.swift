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
    //@State private var selectedMood: MoodTypes? = nil
    //@State private var selectedTime: MoodTimes? = nil
    @Binding var foods: [Food] // Assume this is passed from the ContentView

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
            Text("Breakfast")
            TextField("", text: $foodBreakfast)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                  //.padding()
            Text("Lunch")
            TextField("", text: $foodLunch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                  //.padding()
            Text("Dinner")
            TextField("", text: $foodDinner)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                  //.padding()
            Text("Dessert")
            TextField("", text: $foodDessert)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                  //.padding()
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
                    let newFood = Food(date: date, breakfast: foodBreakfast, lunch: foodLunch, dinner: foodDinner, dessert: foodDessert)
                    foods.append(newFood)
                    //reminderTitle = "" // Reset title for next input
                    //selectedTime = nil // Reset selected time
                    //selectedMood = nil // Reset selected mood
                    foodBreakfast = ""
                    foodLunch = ""
                    foodDinner = ""
                    foodDessert = ""
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.cyan)
                .cornerRadius(8)
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
                        }
                    }
                    HStack{
                        if food.lunch != ""{
                            Text("Lunch").bold()
                            Spacer()
                            Text(food.lunch)
                        }
                    }
                    HStack{
                        if food.dinner != ""{
                            Text("Dinner").bold()
                            Spacer()
                            Text(food.dinner)
                        }
                    }
                    HStack{
                        if food.dessert != ""{
                            Text("Dessert").bold()
                            Spacer()
                            Text(food.dessert)
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
}

enum MoodTypes: String, CaseIterable, Identifiable {
    case happy = "Happy"
    case sad = "Sad"
    case excited = "Excited"
    case tired = "Tired"
    
    var id: String { self.rawValue }
}

//enum MoodTimes: String, CaseIterable, Identifiable {
//    case morning = "Morning"
//    case midday = "Midday"
//    case night = "Night"
//   
//    var id: String { self.rawValue }
//}
