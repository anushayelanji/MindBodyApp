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
    var date: Date
    //@State private var reminderTitle = ""
    @State private var selectedMood: MoodType? = nil
    @State private var selectedTime: MoodTime? = nil
    @Binding var reminders: [Reminder] // Assume this is passed from the ContentView

    var body: some View {
        VStack {
//            TextField("Reminder Title", text: $reminderTitle)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
            
            Picker("Moofsd", selection: $selectedTime) {
                //Text("None").tag(MoodType?.none)
                ForEach(MoodTime.allCases) { mood in
                    Text(mood.rawValue).tag(mood as MoodTime?)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding()

            Picker("Mood", selection: $selectedMood) {
                //Text("None").tag(MoodType?.none)
                ForEach(MoodType.allCases) { mood in
                    Text(mood.rawValue).tag(mood as MoodType?)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button("Add Reminder") {
                let newReminder = Reminder(date: date, time: selectedTime, mood: selectedMood)
                reminders.append(newReminder)
                //reminderTitle = "" // Reset title for next input
                selectedTime = nil // Reset selected time
                selectedMood = nil // Reset selected mood
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)

            List(reminders.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }) { reminder in
                HStack {
                    if let mood = reminder.time {
                        Text(mood.rawValue)
                            
                    }
                    Spacer()
                    if let mood = reminder.mood {
                        Text(mood.rawValue)
                            .foregroundColor(.gray)
                            .italic()
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
        .navigationTitle("Add Reminder")
        .padding()
    }
}


struct Reminder: Identifiable, Hashable {
    var id = UUID()
    //ar title: String
    var date: Date
    var time: MoodTime?
    var mood: MoodType?
}

enum MoodType: String, CaseIterable, Identifiable {
    case happy = "Happy"
    case sad = "Sad"
    case excited = "Excited"
    case tired = "Tired"
    
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
