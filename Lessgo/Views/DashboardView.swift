//
//  DashboardView.swift
//  Lessgo
//
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ChatView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chat")
                }
            FeedView()
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
