//
//  HealthManager.swift
//  pleasehelp
//
//  Created by Vinny on 2/12/24.
//

import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    @Published var activities: [String : Activity] = [:]
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        
        let healthTypes: Set = [steps, calories]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                fetchTodaySteps()
                fetchTodayCalories()
            } catch {
                print ("errror fetchinig health data")
            }
        }
    }
    
    
    
    func fetchTodaySteps() {
        let steps = HKQuantityType(.stepCount)
       // let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("step fetch error")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = Activity(id: 0, title: "Steps taken today", subtitle: "Subtitle", image: "figure.walk", amount: stepCount.formattedString())
            DispatchQueue.main.async {
                self.activities["todaySteps"] = activity
            }
            
            print(stepCount)
        }
        
        healthStore.execute(query)
    }
    
    func fetchTodayCalories() {
        let steps = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("calorie fetch error")
                return
            }
            let stepCount = quantity.doubleValue(for: .kilocalorie())
            let activity = Activity(id: 1, title: "Calories Burned", subtitle: "cum <3", image: "flame", amount: stepCount.formattedString())
            DispatchQueue.main.async {
                self.activities["todayCalories"] = activity
            }
            
            print(stepCount)
        }
        
        healthStore.execute(query)
    }

    
}

extension Double {
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
