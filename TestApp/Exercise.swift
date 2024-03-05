//
//  Exercise.swift
//  TestApp
//
//  Created by Anusha Yelanji on 2/26/24.
//

import Foundation

import SwiftUI

struct Exercise: View {
    @EnvironmentObject var manager: HealthManager
    
    var body: some View {
        NavigationView{
            FitnessView()
        }
        Text("Uikit")
            .navigationTitle("Fitness")
    }
}
