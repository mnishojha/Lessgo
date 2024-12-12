import SwiftUI

struct ChatDetailView: View {
    let chatPartner: String
    @State private var messageText = ""
    @State private var messages: [Message] = [
        // Sample messages - replace with actual chat history from Firebase
        Message(id: "1", content: "Hey! How's your trip planning going?", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-86400)),
        Message(id: "2", content: "It's going great! I'm thinking about visiting Paris next month", isFromCurrentUser: true, timestamp: Date().addingTimeInterval(-85400)),
        Message(id: "3", content: "That's awesome! I was there last summer", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-84400)),
        Message(id: "4", content: "Any recommendations for places to visit?", isFromCurrentUser: true, timestamp: Date().addingTimeInterval(-83400)),
        Message(id: "5", content: "Definitely check out the local cafes in Montmartre!", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-82400))
    ]
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Chat messages
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                                    .padding(.horizontal)
                                    .id(message.id)
                            }
                        }
                        .padding(.top)
                    }
                    .onChange(of: messages) { _, newMessages in
                        if let lastMessage = newMessages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Message input field
                VStack {
                    Divider()
                        .background(Color.gray)
                    
                    HStack(spacing: 12) {
                        TextField("Message", text: $messageText)
                            .padding(12)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(20)
                            .focused($isFocused)
                            .foregroundColor(.white)
                            .accentColor(.blue)
                            .font(.system(size: 16))
                            .placeholder(when: messageText.isEmpty) {
                                Text("Message")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 16))
                                    .padding(.leading, 16)
                            }
                        
                        Button(action: sendMessage) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(messageText.isEmpty ? .gray : .blue)
                                .padding(8)
                                .background(
                                    Circle()
                                        .fill(messageText.isEmpty ? Color.gray.opacity(0.3) : Color.blue.opacity(0.2))
                                )
                        }
                        .disabled(messageText.isEmpty)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color.black.opacity(0.95))
            }
        }
        .navigationTitle(chatPartner)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(chatPartner)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Online")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        
        // Create new message
        let newMessage = Message(
            id: UUID().uuidString,
            content: messageText,
            isFromCurrentUser: true,
            timestamp: Date()
        )
        
        // Add to messages array
        withAnimation {
            messages.append(newMessage)
        }
        
        // Clear input field
        messageText = ""
        
        // Simulate response after 1-2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1...2)) {
            let response = Message(
                id: UUID().uuidString,
                content: getRandomResponse(),
                isFromCurrentUser: false,
                timestamp: Date()
            )
            withAnimation {
                messages.append(response)
            }
        }
    }
    
    private func getRandomResponse() -> String {
        let responses = [
            "That's interesting!",
            "Tell me more about that",
            "Sounds good!",
            "Great idea!",
            "I'll keep that in mind",
            "Thanks for sharing!",
            "How exciting!",
            "That's awesome!"
        ]
        return responses.randomElement() ?? "Cool!"
    }
}

// Message model
struct Message: Identifiable, Equatable {
    let id: String
    let content: String
    let isFromCurrentUser: Bool
    let timestamp: Date
    
    // Implement Equatable
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id &&
        lhs.content == rhs.content &&
        lhs.isFromCurrentUser == rhs.isFromCurrentUser &&
        lhs.timestamp == rhs.timestamp
    }
}

// Message bubble view
struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isFromCurrentUser { Spacer() }
            
            VStack(alignment: message.isFromCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .padding(12)
                    .background(message.isFromCurrentUser ? Color.blue : Color.gray.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                
                Text(formatDate(message.timestamp))
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
            }
            
            if !message.isFromCurrentUser { Spacer() }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatDetailView(chatPartner: "Manish")
        }
    }
} 
