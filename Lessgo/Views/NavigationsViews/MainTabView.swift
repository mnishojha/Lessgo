//
//  MainTabView.swift
//  Lessgo
//

import SwiftUI

struct MainTabView: View {
    @State private var showAddView = false  // State variable to control showing a new view

    var body: some View {
        ZStack {
            // Main TabView
            TabView {
                TravelHomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                FeedView()
                    .tabItem {
                        Label("Feed", systemImage: "globe")
                    }
                MatchingView()
                    .tabItem {
                        Label("Matching", systemImage: "heart.circle")
                    }
                ChatView()
                    .tabItem {
                        Label("Chat", systemImage: "message.fill")
                    }
            }
            .accentColor(.blue)

            // Add Button Overlay
            VStack {
                Spacer()
                AddButton {
                    showAddView.toggle()
                }
                .offset(y: -20) // Adjust button position above TabView
            }
        }
        .sheet(isPresented: $showAddView) {
            AddContentView()  // Replace this with the actual content you want to show
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
