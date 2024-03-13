import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    @ObservedObject var userEntries = UserEntries()
    
    @State private var selectedDate = Date()
    @State private var showingReminderView = false
    @State private var showingFoodView = false
    @State private var reminders: [Reminder] = []
    @State private var foods: [Food] = []
    @State private var first = false
    @State private var second = false
    
    var body: some View {
        NavigationView {
            //date picker
            VStack {
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
            
                HStack{
                    Button("Add Mood") {
                        showingReminderView = true
                        //first = true
                    }.font(.headline)
                        .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                        .padding()
                        .frame(width: 150)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843160629272, green: 0.8078431487083435, blue: 0.8196078538894653, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.7529411911964417, blue: 0.9764705896377563, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        //.padding()
                    
                    .sheet(isPresented: $showingReminderView) {
                        if let userID = sessionManager.currentUser?.username {
                            ReminderView(userID: userID, date: selectedDate, reminders: $reminders)
                           
                        } else {
                            Text("No user logged in")
                        }
                    }
                    
                    Button("Add Food") {
                        showingFoodView = true
                        //second = true
                    }.font(.headline)
                        .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                        .padding()
                        .frame(width: 150)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843160629272, green: 0.8078431487083435, blue: 0.8196078538894653, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.7529411911964417, blue: 0.9764705896377563, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        //.padding()
                    
                    .sheet(isPresented: $showingFoodView) {
                        if let userID = sessionManager.currentUser?.username {
                            FoodView(userID: userID, date: selectedDate, foods: $foods)
                        } else {
                            Text("No user logged in")
                        }
                    }
                }
                
                //view of moods and foods inputted
                HStack{
                    let userID = sessionManager.currentUser?.username
                    
                    //mood display
                    VStack{
                        
                        List(userEntries.data.filter {$0.name == userID}) { userModel in
                            
                            VStack(alignment: .leading) {
                                
                                Text("\(userModel.date, formatter: itemFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                if userModel.morningMood != nil{
                                    Text("Morning Mood").bold().font(.caption)
                                    Text(userModel.morningMood ?? " ")
                                        .font(.caption)
                                }
                                
                                if userModel.middayMood != nil{
                                    Text("Midday Mood").bold().font(.caption)
                                    Text(userModel.middayMood ?? " ")
                                        .font(.caption)
                                }
                                
                                if userModel.nightMood != nil{
                                    Text("Night Mood").bold().font(.caption)
                                    Text(userModel.nightMood ?? " ")
                                        .font(.caption)
                                    
                                }
                            }
                        }
                    }
                    //food display
                    VStack{
                        
                        List(userEntries.data.filter {$0.name == userID}) { food in
                                VStack(alignment: .leading) {
                                    
                                    Text("\(food.date, formatter: itemFormatter)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    if food.breakfast != nil{
                                        Text("Breakfast")
                                            .font(.caption)
                                            .bold()
                                        HStack{
                                            Text(food.breakfast ?? " ")
                                                .font(.caption2)
                                            Spacer()
                                            Text(food.cal_brek ?? " ")
                                                .font(.caption2)
                                        }
                                    }
                                    
                                    if food.lunch != nil{
                                        Text("Lunch")
                                            .font(.caption)
                                            .bold()
                                        HStack{
                                            Text(food.lunch ?? " ")
                                                .font(.caption2)
                                            Spacer()
                                            Text(food.cal_lun ?? " ")
                                                .font(.caption2)
                                        }
                                    }
                                    
                                    if food.dinner != nil{
                                        Text("Dinner")
                                            .font(.caption)
                                            .bold()
                                        HStack{
                                            Text(food.dinner ?? " ")
                                                .font(.caption2)
                                            Spacer()
                                            Text(food.cal_din ?? " ")
                                                .font(.caption2)
                                        }
                                    }
                                    
                                    if food.dessert != nil{
                                        Text("Dessert")
                                            .font(.caption)
                                            .bold()
                                        HStack{
                                            Text(food.dessert ?? " ")
                                                .font(.caption2)
                                            Spacer()
                                            Text(food.cal_des ?? " ")
                                                .font(.caption2)
                                        }
                                    }
                                    
                            }
                        }
                    }
                }
            }.navigationTitle("Calendar")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()
