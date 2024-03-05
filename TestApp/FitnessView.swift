
import Foundation
//
//  HomeView.swift
//  pleasehelp
//
//  Created by Vinny on 2/12/24.
//

import SwiftUI

struct FitnessView: View {
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        VStack{
            LazyVGrid(columns: Array(repeating: GridItem(spacing:20), count: 1)) {
                ForEach(manager.activities.sorted(by: { $0.value.id < $1.value.id}), id: \.key) { item in
                    ActivityCard(activity: item.value)
                    
                }
                
            }
        }.navigationTitle("Fitness")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessView()
    }
}
