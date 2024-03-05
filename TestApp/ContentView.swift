//
//  ContentView.swift
//  TestApp
//
//  Created by John Chen on 2/13/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    @State private var selectedDate = Date()
//    @State private var showReminder = false
//    
//    var body: some View {
//        VStack {
//            DatxaxePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
//                .datePickerStyle(GraphicalDatePickerStyle())
//                .padding()
//                .onChange(of: selectedDate) { _ in
//                    showReminder = true
//                }
//            
//            NavigationLink(destination: ReminderView(date: selectedDate), isActive: $showReminder) {
//                EmptyView()
//            }
//        }
//        .navigationTitle("Calendar")
//    }
//}
//
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var showingReminderView = false
    @State private var showingFoodView = false
    @State private var reminders: [Reminder] = []
    @State private var foods: [Food] = []
    @State private var first = false
    @State private var second = false

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    //.padding()
                HStack{
                    Button("Add Mood") {
                        showingReminderView = true
                        first = true
                    }.padding()
                    
                        .sheet(isPresented: $showingReminderView) {
                            ReminderView(date: selectedDate, reminders: $reminders)
                        }
                    
                    Button("Add Food") {
                        showingFoodView = true
                        second = true
                    }
                    .sheet(isPresented: $showingFoodView) {
                        FoodView(date: selectedDate, foods: $foods)
                    }
                }
                HStack{
                    VStack{
                        
                        if first{Text("Moods").bold()}
                        List(reminders) { reminder in
                            
                            VStack(alignment: .leading) {
                                //Text(reminder.title)
                                
                                Text("\(reminder.date, formatter: itemFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                if let mood = reminder.time {
                                    Text(mood.rawValue)
                                        .font(.caption)
                                        .bold()
                                        //.foregroundColor(.secondary)
                                    
                                }
                                
                                if let mood = reminder.mood {
                                    Text(mood.rawValue)
                                        .font(.caption2)
                                        //.foregroundColor(.secondary)
                                }
                                
                            }
                            
                        }
                    }
                  
                    
                    VStack{
                        if second{Text("Foods eaten").bold()}
                        
                        List(foods) { food in
                            VStack(alignment: .leading) {
                                //Text(reminder.title)
                                
                                
                                Text("\(food.date, formatter: itemFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                //                        if let mood = reminder.time {
                                //                            Text(mood.rawValue)
                                //                                .font(.caption2)
                                //                                .bold()
                                //                                .foregroundColor(.secondary)
                                //
                                //                        }
                                
                                
                                if food.breakfast != ""{
                                    Text("Breakfast")
                                        .font(.caption)
                                        .bold()
                                    HStack{
                                        Text(food.breakfast)
                                            .font(.caption2)
                                        Spacer()
                                        Text(food.cal_brek)
                                            .font(.caption2)
                                    }
                                }
                                
                                if food.lunch != ""{
                                    Text("Lunch")
                                        .font(.caption)
                                        .bold()
                                    HStack{
                                        Text(food.lunch)
                                            .font(.caption2)
                                        Spacer()
                                        Text(food.cal_lun)
                                            .font(.caption2)
                                    }
                                }
                                
                                if food.dinner != ""{
                                    Text("Dinner")
                                        .font(.caption)
                                        .bold()
                                    HStack{
                                        Text(food.dinner)
                                            .font(.caption2)
                                        Spacer()
                                        Text(food.cal_din)
                                            .font(.caption2)
                                    }
                                }
                                
                                if food.dessert != ""{
                                    Text("Dessert")
                                        .font(.caption)
                                        .bold()
                                    HStack{
                                        Text(food.dessert)
                                            .font(.caption2)
                                        Spacer()
                                        Text(food.cal_des)
                                            .font(.caption2)
                                    }
                                }
                                
                            }
                        }
                    }
                }
                    
                 
                
            }
            .navigationTitle("Calendar")
            
        }
      
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()



