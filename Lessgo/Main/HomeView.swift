//
//  HomeView.swift
//  Lessgo
//
//  Created by manish ojha on 31/10/24.
//

import SwiftUI

struct HomesView: View {
    @State private var searchText = ""
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Hello")
                            .foregroundColor(.gray)
                        Text("Max's")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image("profile_placeholder")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                }
                .padding()
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search Trips", text: $searchText)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                ScrollView {
                    // Trending Plans
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Trending Plans")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            Button("See more") {
                                // Action
                            }
                            .foregroundColor(.blue)
                        }
                        
                        HStack(spacing: 16) {
                            TrendingPlanCard(
                                image: "BOYS_placeholder",
                                title: " BOYS TRIP",
                                country: "INDIA",
                                participants: 50
                            )
                            
                            TrendingPlanCard(
                                image: "MAIMI_placeholder",
                                title: "Maimi's trippp!!!",
                                country: "USA",
                                participants: 35
                            )
                        }
                    }
                    .padding()
                    
                    // Plans you joined
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Plans you joined")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            Button("See all") {
                                // Action
                            }
                            .foregroundColor(.blue)
                        }
                        
                        HStack {
                            Image("no_plans_placeholder")
                                .resizable()
                                .frame(width: 64, height: 64)
                            VStack(alignment: .leading) {
                                Text("No Plans Yet")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text("You haven't joined any plans")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(16)
                    }
                    .padding()
                    
                    // Discover countries
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Discover countries")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            Button("See all") {
                                // Action
                            }
                            .foregroundColor(.blue)
                        }
                        
                        HStack(spacing: 16) {
                            Image("country1_placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                            Image("country2_placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                // Bottom Navigation
                HStack {
                    BottomNavItem(icon: "house.fill", color: .blue)
                    BottomNavItem(icon: "globe", color: .gray)
                    BottomNavItem(icon: "plus", color: .white, background: .blue)
                    BottomNavItem(icon: "mappin", color: .gray)
                    BottomNavItem(icon: "message", color: .gray)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
        }
        .foregroundColor(.white)
    }
}

struct TrendingPlanCard: View {
    let image: String
    let title: String
    let country: String
    let participants: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Text(title)
                .fontWeight(.semibold)
                .lineLimit(1)
                .foregroundColor(.white)
            
            HStack {
                Text(country)
                Spacer()
                Image(systemName: "person.fill")
                Text("\(participants)")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
    }
}

struct BottomNavItem: View {
    let icon: String
    let color: Color
    var background: Color = .clear
    
    var body: some View {
        Button(action: {
            // Action
        }) {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 44, height: 44)
                .background(background)
                .clipShape(Circle())
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
