import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var morningMood: String?
    @NSManaged public var middayMood: String?
    @NSManaged public var nightMood: String?
    @NSManaged public var breakfast: String?
    @NSManaged public var lunch: String?
    @NSManaged public var dinner: String?
    @NSManaged public var dessert: String?
    @NSManaged public var name: String
    @NSManaged public var date: Date
    @NSManaged public var cal_brek: String?
    @NSManaged public var cal_lun: String?
    @NSManaged public var cal_din: String?
    @NSManaged public var cal_des: String?
    @NSManaged public var total_cals: NSNumber?
    @NSManaged public var total_steps: NSNumber?
}
