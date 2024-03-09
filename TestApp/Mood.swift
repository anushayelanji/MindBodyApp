import SwiftUI

struct ReminderView: View {
    var userID: String
    var date: Date
    @State private var selectedMood: MoodType? = nil
    @State private var selectedTime: MoodTime? = nil
    @Binding var reminders: [Reminder]
    
    var body: some View {
        VStack {

            Text("Mood")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .padding()
            
            Picker("Time", selection: $selectedTime) {
                ForEach(MoodTime.allCases) { mood in
                    Text(mood.rawValue).tag(mood as MoodTime?)
                }.font(.title)
            }.pickerStyle(SegmentedPickerStyle())
                .padding()

            Picker("Mood", selection: $selectedMood) {
                ForEach(MoodType.allCases) { mood in
                    Text(mood.rawValue).tag(mood as MoodType?)
                }
            
            }.pickerStyle(SegmentedPickerStyle())
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
                    
//                    let userEntries = CoreDataManager.shared.fetchUserEntries()
//                    
//                    //printing all data
//                    for entry in userEntries {
//                        print(entry)
//                    }
                    
                    selectedTime = nil // Reset selected time
                    selectedMood = nil // Reset selected mood
                    

                }
                .font(.headline)
                .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                .padding()
                .frame(width: 300)
                .background(selectedTime == nil || selectedMood == nil ? Color.gray : Color(#colorLiteral(red: 0.9607843160629272, green: 0.8078431487083435, blue: 0.8196078538894653, alpha: 1)))
                .cornerRadius(10)
                .padding()
                .disabled(selectedTime == nil || selectedMood == nil)
                
            }
            .padding(30)

            //view of data that has just been added
            List(reminders.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
                reminder in
                HStack {
                    if let mood = reminder.time {
                        Text(mood.rawValue).bold()
                            
                    }
                    Spacer()
                    if let mood = reminder.mood {
                        Text(mood.rawValue)
                    }

                }
            }
        }
        .padding()
        //.padding()
    }
        
}


struct Reminder: Identifiable, Hashable {
    var id = UUID()
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
