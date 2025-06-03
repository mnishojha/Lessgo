//
//  MainTabView.swift
//  Lessgo
//

import SwiftUI

struct MainTabView: View {
    @State private var showAddView = false
    @State private var selectedTab = 0
    @State private var isInChatDetail = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                TravelHomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)
                
                FeedsView()
                    .tabItem {
                        Label("Feed", systemImage: "globe")
                    }
                    .tag(1)
                
                MatchingView()
                    .tabItem {
                        Label("Matching", systemImage: "heart.circle")
                    }
                    .tag(2)
                
                ChatView(isInChatDetail: $isInChatDetail)
                    .tabItem {
                        Label("Chat", systemImage: "message.fill")
                    }
                    .tag(3)
            }
            .accentColor(.blue)
            
            // Show add button when not in chat detail
            if !isInChatDetail {
                VStack {
                    Spacer()
                    AddButton {
                        showAddView.toggle()
                    }
                    .offset(y: -20)
                }
            }
        }
        .sheet(isPresented: $showAddView) {
            AddContentView()
        }
    }
}

// Define the AddButton as a separate view if you haven't already
struct AddButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)
                .background(Circle().fill(Color.white))
                .clipShape(Circle())
                .shadow(radius: 10)
        }
        .frame(width: 60, height: 60)
    }
}

// Example Add Content View
struct AddContentView: View {
    var body: some View {
        Text("Add New Content Here")
            .font(.title)
            .padding()
    }
}

#Preview {
    MainTabView()
}
