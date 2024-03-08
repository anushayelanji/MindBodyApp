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


//struct ActivityCard: View {
//    @State var activity: Activity
//    var body: some View {
//        VStack {
//            HStack(alignment: .top) {
//                VStack{
//                    Text(activity.title).bold()
//                    
//                    Text(activity.subtitle)
//                        .font(.caption)
//                }
//                Spacer()
//
//            }
//            .padding()
//            
//            Text(activity.amount)
//                .font(.system(size: 60))
//              
//            //   .font(.system(size: 20))
//            Spacer(minLength: 40)
//        }
//        .background(Color.blue)
//        .cornerRadius(20)
//        Spacer(minLength: 90)
//        
//    }
//}

struct ActivityCard: View {
    @State var activity: Activity
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(activity.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                    
                    
                    Text(activity.subtitle)
                        .font(.caption)
                        .foregroundColor(.white)
                }
                Spacer()
//                Image(systemName: activity.image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 40, height: 40)
//                    .foregroundColor(.white)
            }
            .padding()
            
            Text(activity.amount)
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843160629272, green: 0.8078431487083435, blue: 0.8196078538894653, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.7529411911964417, blue: 0.9764705896377563, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(20)
        .padding()
    }
}


//struct Activitycard_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityCard(activity: Activity(id: 0, title: "Daily steps", subtitle: "Goal:10,000", image: "figure.walk", amount: "xxx" ))
//
//    }
//}
