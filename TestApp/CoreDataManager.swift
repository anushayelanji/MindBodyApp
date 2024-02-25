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
    
    func cacheFoodItems(foodItems: [(name: String, calories: Int)]) {
        let context = persistentContainer.viewContext
        for foodItem in foodItems {
            let entity = NSEntityDescription.entity(forEntityName: "FoodItem", in: context)!
            let foodItemObject = NSManagedObject(entity: entity, insertInto: context)
            foodItemObject.setValue(foodItem.name, forKey: "name")
            foodItemObject.setValue(foodItem.calories, forKey: "calories")
        }
        saveContext()
    }
    
    func fetchFoodItems() -> [FoodItem] {
        let fetchRequest: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        do {
            let foodItems = try context.fetch(fetchRequest)
            return foodItems
        } catch {
            print("Failed to fetch food items: \(error)")
            return []
        }
    }
    
    func cacheUserEntry(userEntry: UserModel) {
        let context = persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
        let userObject = NSManagedObject(entity: entity, insertInto: context)
        userObject.setValue(userEntry.name, forKey: "name")
        userObject.setValue(userEntry.breakfast, forKey: "breakfast")
        userObject.setValue(userEntry.morningMood, forKey: "morningMood")
        userObject.setValue(userEntry.date, forKey: "date")
        
        saveContext()
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
