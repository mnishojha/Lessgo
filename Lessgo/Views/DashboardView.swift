//
//  DashboardView.swift
//  Lessgo
//
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabView{
             MainTabView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                
           
                }
            FeedsView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Feed")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
        }
    }
}

#Preview {
    DashboardView()
}
