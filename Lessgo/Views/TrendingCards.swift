////
////  TrendingCards.swift
////  Lessgo
////
////  Created by Israel on 11/1/24.
////
//
//import SwiftUI
//
//
//struct TrendingPlanCard: View {
//    let image: String
//    let title: String
//    let country: String
//    let participants: Int
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            TrendingPlanImage(imageName: image)
//            TrendingPlanDetails(title: title, country: country, participants: participants)
//        }
//        .frame(width: 280)
//        .background(Color.gray.opacity(0.1))
//        .cornerRadius(16)
//    }
//}
//
//struct TrendingPlanImage: View {
//    let imageName: String
//
//    var body: some View {
//        Image(imageName)
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .frame(width: 280, height: 180)
//            .clipped()
//            .cornerRadius(16)
//    }
//}
//
//struct TrendingPlanDetails: View {
//    let title: String
//    let country: String
//    let participants: Int
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Text(title)
//                .font(.title3)
//                .fontWeight(.bold)
//
//            HStack {
//                Text(country)
//                    .foregroundColor(.gray)
//                Spacer()
//                Image(systemName: "person.fill")
//                    .foregroundColor(.gray)
//                Text("\(participants)")
//                    .foregroundColor(.gray)
//            }
//        }
//    }
//}
//
////#Preview {
////    TrendingCards()
////}
