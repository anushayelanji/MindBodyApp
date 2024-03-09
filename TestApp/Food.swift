import SwiftUI

struct FoodView: View {
    var userID: String
    var date: Date
    @State private var foodBreakfast = ""
    @State private var foodLunch = ""
    @State private var foodDinner = ""
    @State private var foodDessert = ""
    @State private var food_cal_brek = ""
    @State private var food_cal_lun = ""
    @State private var food_cal_din = ""
    @State private var food_cal_des = ""
    @Binding var foods: [Food]

    var body: some View {
        VStack {
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
            .pickerStyle(SegmentedPickerStyle())
            .padding(20)
            
            VStack{
                //adding food functionality
                Button("Add Food") {
                    let newFood = Food(date: date, breakfast: foodBreakfast, lunch: foodLunch, dinner: foodDinner, dessert: foodDessert, cal_brek: food_cal_brek, cal_lun: food_cal_lun, cal_din: food_cal_din, cal_des: food_cal_des)
                    foods.append(newFood)
                    
                    let userModel = UserModel(name: userID, date: date, breakfast: foodBreakfast.isEmpty ? nil : foodBreakfast, lunch: foodLunch.isEmpty ? nil : foodLunch, dinner: foodDinner.isEmpty ? nil : foodDinner, dessert: foodDessert.isEmpty ? nil : foodDessert, cal_brek: food_cal_brek.isEmpty ? nil : food_cal_brek, cal_lun: food_cal_lun.isEmpty ? nil : food_cal_lun, cal_din: food_cal_din.isEmpty ? nil : food_cal_din, cal_des: food_cal_des.isEmpty ? nil : food_cal_des)
                    CoreDataManager.shared.updateUserEntry(name: userModel.name, date: userModel.date, userModel: userModel)
                    
                    foodBreakfast = ""
                    foodLunch = ""
                    foodDinner = ""
                    foodDessert = ""
                    food_cal_brek = ""
                    food_cal_lun = ""
                    food_cal_din = ""
                    food_cal_des = ""
                    
                    //just printing all the entries
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
                        
            
                    }
                }
                .font(.headline)
                .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                .padding()
                .frame(width: 300)
                .background(foodBreakfast == "" && foodLunch == "" && foodDinner == "" && foodDessert == "" ? Color.gray : Color(#colorLiteral(red: 0.9607843160629272, green: 0.8078431487083435, blue: 0.8196078538894653, alpha: 1)))
                .cornerRadius(10)
                .padding()
                .disabled(foodBreakfast == "" && foodLunch == "" && foodDinner == "" && foodDessert == "" )

            }
            .padding()
            List(foods.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }) { food in
                VStack {

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

                }
            }
        }
        .padding()
   
        .padding()
    }
    

        
}

struct Food: Identifiable, Hashable {
    var id = UUID()
    var date: Date
    var breakfast: String
    var lunch: String
    var dinner: String
    var dessert: String
    var cal_brek: String
    var cal_lun: String
    var cal_din: String
    var cal_des: String
}


