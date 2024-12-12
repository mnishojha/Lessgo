//
//  ChatView.swift
//  Lessgo
//
//  Created by manish ojha on 01/11/24.
//
import SwiftUI

struct ChatView: View {
    @Binding var isInChatDetail: Bool
    @State private var searchText = ""
    
    // Sample chat data - replace with your actual data model/firebase model
    let chats = [
        ["name": "John Doe", "lastMessage": "Hey, how are you?"],
        ["name": "Jane Smith", "lastMessage": "See you tomorrow!"],
        ["name": "Mike Johnson", "lastMessage": "Thanks for the help!"]
    ]
    
    // Filtered chats based on search text
    var filteredChats: [[String: String]] {
        if searchText.isEmpty {
            return chats
        }
        return chats.filter { chat in
            let name = chat["name"]?.lowercased() ?? ""
            let message = chat["lastMessage"]?.lowercased() ?? ""
            let searchQuery = searchText.lowercased()
            
            return name.contains(searchQuery) || message.contains(searchQuery)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Chats")
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
                                Text("Search chats")
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
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Chat List
                    if filteredChats.isEmpty {
                        VStack(spacing: 20) {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("No matches found")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(filteredChats, id: \.["name"]) { chat in
                                    NavigationLink(
                                        destination: ChatDetailView(chatPartner: chat["name"] ?? "")
                                            .onAppear { isInChatDetail = true }
                                            .onDisappear { isInChatDetail = false }
                                    ) {
                                        ChatRow(name: chat["name"] ?? "", 
                                               lastMessage: chat["lastMessage"] ?? "")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct ChatRow: View {
    let name: String
    let lastMessage: String
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile Picture
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 50, height: 50)
            
            // Chat Info
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.black)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(isInChatDetail: .constant(false))
            .preferredColorScheme(.dark)
    }
}
