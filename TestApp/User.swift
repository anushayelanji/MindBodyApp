//
//  User.swift
//  TestApp
//
//  Created by Ravi on 2/25/24.
//

import Foundation

struct UserModel : Identifiable {
    
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
 
}
//
//import Foundation
//
//struct UserModel {
//    
//    var name: String
//    var date: Date
//    var morningMood: String?
//    var middayMood: String?
//    var nightMood: String?
//    var breakfast: String?
//    var lunch: String?
//    var dinner: String?
//    var dessert: String?
//    var cal_brek: String?
//    var cal_lun: String?
//    var cal_din: String?
//    var cal_des: String?
// 
//}
