import Foundation

struct UserModel: Identifiable {
    let id: UUID = UUID()
    var name: String
    var date: Date
    var morningMood: String?
    var middayMood: String?
    var nightMood: String?
    var breakfast: String?
    var lunch: String?
    var dinner: String?
    var dessert: String?
    var cal_brek: String?
    var cal_lun: String?
    var cal_din: String?
    var cal_des: String?
    var total_cals: Int32?
    var total_steps: Int32?
 
}
