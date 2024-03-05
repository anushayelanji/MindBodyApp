//
//  CoreDataManager.swift
//  TestApp
//
//  Created by Ravi on 2/18/24.
//


import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MindBodyModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    func cacheFoodItems(foodItems: [(name: String, calories: Int)]) {
//        let context = persistentContainer.viewContext
//        for foodItem in foodItems {
//            let entity = NSEntityDescription.entity(forEntityName: "FoodItem", in: context)!
//            let foodItemObject = NSManagedObject(entity: entity, insertInto: context)
//            foodItemObject.setValue(foodItem.name, forKey: "name")
//            foodItemObject.setValue(foodItem.calories, foruserKey: "calories")
//        }
//        saveContext()
//    }
//    
//    func fetchFoodItems() -> [FoodItem] {
//        let fetchRequest: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
//        do {
//            let foodItems = try context.fetch(fetchRequest)
//            return foodItems
//        } catch {
//            print("Failed to fetch food items: \(error)")
//            return []
//        }
//    }
    
//    func cacheUserEntry(userEntry: UserModel) {
//        let context = persistentContainer.viewContext
//        
//        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
//        let userObject = NSManagedObject(entity: entity, insertInto: context)
//        userObject.setValue(userEntry.name, forKey: "name")
//        userObject.setValue(userEntry.breakfast, forKey: "breakfast")
//        userObject.setValue(userEntry.morningMood, forKey: "morningMood")
//        userObject.setValue(userEntry.date, forKey: "date")
//        
//        saveContext()
//    }
    
    func updateUserEntry(name: String, date: Date, userModel: UserModel) {
        let context = persistentContainer.viewContext

        // Extract the date components from the given date
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)

        // Construct the start and end dates for the given date
        guard let startDate = calendar.date(from: dateComponents),
              let endDate = calendar.date(byAdding: .day, value: 1, to: startDate) else {
            return
        }

        // Check if an entry with the given name and date exists
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND date >= %@ AND date < %@", name, startDate as NSDate, endDate as NSDate)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let existingUser = result.first as? NSManagedObject {
                // Entry exists, update it
                existingUser.setValue(userModel.name, forKey: "name")
                existingUser.setValue(userModel.date, forKey: "date")
                
                if let breakfast = userModel.breakfast {
                    existingUser.setValue(breakfast, forKey: "breakfast")
                }
                if let lunch = userModel.lunch {
                    existingUser.setValue(lunch, forKey: "lunch")
                }
                if let dinner = userModel.dinner {
                    existingUser.setValue(dinner, forKey: "dinner")
                }
                if let dessert = userModel.dessert{
                    existingUser.setValue(dessert, forKey: "dessert")
                }
                if let morningMood = userModel.morningMood{
                    existingUser.setValue(morningMood, forKey: "morningMood")
                }
                if let morningMood = userModel.morningMood{
                    existingUser.setValue(morningMood, forKey: "morningMood")
                }
                if let middayMood = userModel.middayMood{
                    existingUser.setValue(middayMood, forKey: "middayMood")
                }
                if let nightMood = userModel.nightMood{
                    existingUser.setValue(nightMood, forKey: "nightMood")
                }
                if let cal_brek = userModel.cal_brek{
                    existingUser.setValue(cal_brek, forKey: "cal_brek")
                }
                if let cal_lun = userModel.cal_lun{
                    existingUser.setValue(cal_lun, forKey: "cal_lun")
                }
                if let cal_din = userModel.cal_din{
                    existingUser.setValue(cal_din, forKey: "cal_din")
                }
                if let cal_des = userModel.cal_des {
                    existingUser.setValue(cal_des , forKey: "cal_des")
                }
                if let total_cals = userModel.total_cals {
                    existingUser.setValue(total_cals  , forKey: "total_cals")
                }
                if let total_steps = userModel.total_steps {
                    existingUser.setValue(total_steps  , forKey: "total_steps")
                }
                //existingUser.setValue(userModel.morningMood, forKey: "morningMood")
                //existingUser.setValue(userModel.middayMood, forKey: "middayMood")
                //existingUser.setValue(userModel.nightMood, forKey: "nightMood")
                
            } else {
                // Entry does not exist, create a new one
                let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
                let newUser = NSManagedObject(entity: entity, insertInto: context)
                newUser.setValue(userModel.name, forKey: "name")
                newUser.setValue(userModel.date, forKey: "date")
                
                if let breakfast = userModel.breakfast {
                    newUser.setValue(breakfast, forKey: "breakfast")
                }
                if let lunch = userModel.lunch {
                    newUser.setValue(lunch, forKey: "lunch")
                }
                if let dinner = userModel.dinner {
                    newUser.setValue(dinner, forKey: "dinner")
                }
                if let dessert = userModel.dessert{
                    newUser.setValue(dessert, forKey: "dessert")
                }
                if let morningMood = userModel.morningMood{
                    newUser.setValue(morningMood, forKey: "morningMood")
                }
                if let middayMood = userModel.middayMood{
                    newUser.setValue(middayMood, forKey: "middayMood")
                }
                if let nightMood = userModel.nightMood{
                    newUser.setValue(nightMood, forKey: "nightMood")
                }
                if let cal_brek = userModel.cal_brek{
                    newUser.setValue(cal_brek, forKey: "cal_brek")
                }
                if let cal_lun = userModel.cal_lun{
                    newUser.setValue(cal_lun, forKey: "cal_lun")
                }
                if let cal_din = userModel.cal_din{
                    newUser.setValue(cal_din, forKey: "cal_din")
                }
                if let cal_des = userModel.cal_des {
                    newUser.setValue(cal_des , forKey: "cal_des")
                }
                
                if let total_cals = userModel.total_cals {
                    newUser.setValue(total_cals  , forKey: "total_cals")
                }
                if let total_steps = userModel.total_steps {
                    newUser.setValue(total_steps  , forKey: "total_steps")
                }
                //newUser.setValue(userModel.morningMood, forKey: "morningMood")
                //newUser.setValue(userModel.middayMood, forKey: "middayMood")
                //newUser.setValue(userModel.nightMood, forKey: "nightMood")
                
            }

            // Save the context
            saveContext()
        } catch {
            print("Failed to update or create user entry: \(error)")
        }
    }
    
    func fetchUserEntries() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let foodUserData = try context.fetch(fetchRequest)
            return foodUserData
        } catch {
            print("Failed to fetch food items: \(error)")
            return []
        }
    }
//    func purgeUserEntity() {
//        let context = persistentContainer.viewContext
//        context
//    }
}
