//
//  GroupChatView.swift
//  Lessgo
//
//  Created by manish ojha on 16/01/25.
//

import SwiftUI

struct GroupChatView: View {
    @Binding var isInChatDetail: Bool
    @State private var searchText = ""
    
    // Sample group chat data
    let chats = [
        ["name": "Study Group", "participants": "John, Jane, Mike", "lastMessage": "Let's meet at 5 PM!"],
        ["name": "Family", "participants": "Mom, Dad, Me", "lastMessage": "Dinner is ready."],
        ["name": "Team Project", "participants": "Alice, Bob, Charlie", "lastMessage": "Great work on the presentation!"]
    ]
    
    // Filtered chats based on search text
    var filteredChats: [[String: String]] {
        if searchText.isEmpty {
            return chats
        }
        return chats.filter { chat in
            let name = chat["name"]?.lowercased() ?? ""
            let message = chat["lastMessage"]?.lowercased() ?? ""
            let participants = chat["participants"]?.lowercased() ?? ""
            let searchQuery = searchText.lowercased()
            
            return name.contains(searchQuery) || message.contains(searchQuery) || participants.contains(searchQuery)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Group Chats")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {}) {
                            Text("Requests (0)")
                                .foregroundColor(.blue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(16)
                        }
                    }
                    .padding()
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("", text: $searchText)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .accentColor(.blue)
                            .autocapitalization(.none)
                            .placeholder(when: searchText.isEmpty) {
                                Text("Search group chats")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 16))
                                    .padding(.leading, 4)
                            }
                            .overlay(
                                HStack {
                                    Spacer()
                                    if !searchText.isEmpty {
                                        Button(action: {
                                            searchText = ""
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                }
                            )
                    }
                    .padding()
                    .background(Color.gray.opacity(0.3))
                   
                    
                }
                
            }
        }
    }
}
#Preview {
   
}
