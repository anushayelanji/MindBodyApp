//
//  ActivityCard.swift
//  TestApp
//
//  Created by Anusha Yelanji on 2/29/24.
//

import Foundation
//
//  ActivityCard.swift
//  pleasehelp
//
//  Created by Vinny on 2/12/24.
//

import SwiftUI

struct Activity {
    let id: Int
    let title: String
    let subtitle: String
    //let image: String
    let amount: String
}


struct ActivityCard: View {
    @State var activity: Activity
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack{
                    Text(activity.title).bold()
                    
                    Text(activity.subtitle)
                        .font(.caption)
                }
                Spacer()
//                Image(activity.image)
//                    .foregroundColor(.cyan)
            }
            .padding()
            
            Text(activity.amount)
                .font(.system(size: 60))
              
            //   .font(.system(size: 20))
            Spacer(minLength: 40)
        }
        .background(Color.blue)
        .cornerRadius(20)
        Spacer(minLength: 90)
        
    }
}

//struct Activitycard_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityCard(activity: Activity(id: 0, title: "Daily steps", subtitle: "Goal:10,000", image: "figure.walk", amount: "xxx" ))
//
//    }
//}
