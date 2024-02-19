//
//  FoodItem+CoreDataClass.swift
//  TestApp
//
//  Created by Ravi on 2/18/24.
//
//

import Foundation
import CoreData

@objc(FoodItem)
public class FoodItem: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var calories: Int16
    @NSManaged public var name: String?
}
