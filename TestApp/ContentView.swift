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
//            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
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
    @State private var reminders: [Reminder] = []

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()

                Button("Add Reminder") {
                    showingReminderView = true
                }
                .sheet(isPresented: $showingReminderView) {
                    ReminderView(date: selectedDate, reminders: $reminders)
                }

                List(reminders) { reminder in
                    VStack(alignment: .leading) {
                        //Text(reminder.title)
                        
                        Text("\(reminder.date, formatter: itemFormatter)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        if let mood = reminder.time {
                            Text(mood.rawValue)
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.secondary)
                            
                        }
                        
                        if let mood = reminder.mood {
                            Text(mood.rawValue)
                                .font(.caption2)
                                .foregroundColor(.secondary)
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



