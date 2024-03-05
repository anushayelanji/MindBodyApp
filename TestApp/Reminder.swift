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

struct ReminderView: View {
    
    var userID: String
    var date: Date
    //@State private var reminderTitle = ""
    @State private var selectedMood: MoodType? = nil
    @State private var selectedTime: MoodTime? = nil
    @Binding var reminders: [Reminder] // Assume this is passed from the ContentView
//    
//    @State private var foodItems: [FoodItem] = []

    var body: some View {
        VStack {
//            TextField("Reminder Title", text: $reminderTitle)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                  .padding()
            Text("Mood")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .padding()
            
            Picker("Time", selection: $selectedTime) {
                //Text("None").tag(MoodType?.none)
                ForEach(MoodTime.allCases) { mood in
                    Text(mood.rawValue).tag(mood as MoodTime?)
                }.font(.title)
            }.pickerStyle(SegmentedPickerStyle())
                .padding()

            Picker("Mood", selection: $selectedMood) {
                //Text("None").tag(MoodType?.none)
                ForEach(MoodType.allCases) { mood in
                    Text(mood.rawValue).tag(mood as MoodType?)
                }
            
            }
            
            .pickerStyle(SegmentedPickerStyle())
            .padding(20)
            VStack{
                
                Button("Add Mood") {
                    let newReminder = Reminder(date: date, time: selectedTime, mood: selectedMood)
                    reminders.append(newReminder)
                    
                    var userModel: UserModel
                    if selectedTime == .morning {
                        userModel = UserModel(name: userID, date: date, morningMood: selectedMood?.rawValue )
                    } else if selectedTime == .midday{
                        userModel = UserModel(name: userID, date: date, middayMood: selectedMood?.rawValue)
                    }else{
                        userModel = UserModel(name: userID, date: date, nightMood: selectedMood?.rawValue)
                    }
                    
                    CoreDataManager.shared.updateUserEntry(name: userModel.name, date: userModel.date, userModel: userModel)
                    
                    let userEntries = CoreDataManager.shared.fetchUserEntries()
                    for entry in userEntries {
//                        print(entry.breakfast ?? "Empty breakfast")
//                        print(entry.morningMood ?? "Empty mood")
                    
                        print(entry)
                    }
                    
                    
                    //reminderTitle = "" // Reset title for next input
                    selectedTime = nil // Reset selected time
                    selectedMood = nil // Reset selected mood
                    
//                    let foodItemsToCache = [("Donut", 200)]
//                    CoreDataManager.shared.cacheFoodItems(foodItems: foodItemsToCache)
//                    
//                    self.foodItems = CoreDataManager.shared.fetchFoodItems()
//                    self.printFoodItems()
                }
//                .padding()
//                .foregroundColor(.white)
//                .background(Color.cyan) 
//                .cornerRadius(8)
                
                .padding()
                .foregroundColor(.white)
                .background(selectedTime == nil || selectedMood == nil ? Color.gray : Color.cyan)
                 .cornerRadius(8)
                 .disabled(selectedTime == nil || selectedMood == nil)
            }
            .padding(30)
            List(reminders.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }) { 
                reminder in
                HStack {
                    if let mood = reminder.time {
                        Text(mood.rawValue).bold()
                            
                    }
                    Spacer()
                    if let mood = reminder.mood {
                        Text(mood.rawValue)
                            //.foregroundColor(.gray)
                            //.italic()
                    }
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


struct Reminder: Identifiable, Hashable {
    var id = UUID()
    //ar title: String
    var date: Date
    var time: MoodTime?
    var mood: MoodType?
}

enum MoodType: String, CaseIterable, Identifiable {
    case sad = "Sad"
    case neutral = "Neutral"
    case happy = "Happy"
    case ecstatic = "Ecstatic"
    
    var id: String { self.rawValue }
}

enum MoodTime: String, CaseIterable, Identifiable {
    case morning = "Morning"
    case midday = "Midday"
    case night = "Night"
   
    var id: String { self.rawValue }
}
//
//
//struct ReminderView: View {
//    var date: Date
//    @State private var reminderTitle: String = ""
//    @State private var selectedMood: MoodType? = nil
//    @Binding var reminders: [Reminder]
//
//    var body: some View {
//        Form {
//            TextField("Reminder Title", text: $reminderTitle)
//            Picker("Mood", selection: $selectedMood) {
//                Text("None").tag(MoodType?.none)
//                ForEach(MoodType.allCases) { mood in
//                    Text(mood.rawValue).tag(mood as MoodType?)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            Button("Add Reminder") {
//                let newReminder = Reminder(title: reminderTitle, date: date, mood: selectedMood)
//                reminders.append(newReminder)
//                // Reset fields or dismiss this view as needed
//            }
//        }
//    }
//}
