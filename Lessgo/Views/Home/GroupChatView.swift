import SwiftUI

struct GroupChatView: View {
    let chatParticipants: [String]
    @State private var messageText = ""
    @State private var messages: [Message] = [
        Message(id: "1", sender: "Blaise", content: "WHO PUSHED MCLAGGEN INTO THE LAKE???", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-86400)),
        Message(id: "2", sender: "Teo", content: "wait WHAT???", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-85400)),
        Message(id: "3", sender: "Enzo", content: "someone fucking pushed him? 😭😭", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-84400)),
        Message(id: "4", sender: "You", content: "SOMEONE PUSHED HIM?\nFUCK\nit should’ve been ME", isFromCurrentUser: true, timestamp: Date().addingTimeInterval(-83400)),
        Message(id: "5", sender: "Enzo", content: "u wanna get thrown in the lake?", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-82400)),
        Message(id: "6", sender: "You", content: "no dumbass i wanted to push him in", isFromCurrentUser: true, timestamp: Date().addingTimeInterval(-81400)),
        Message(id: "7", sender: "Theo", content: "oh my bad", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-80400)),
        Message(id: "8", sender: "You", content: "YOU THREW HIM IN???", isFromCurrentUser: true, timestamp: Date().addingTimeInterval(-79400)),
        Message(id: "9", sender: "Theo", content: "he pissed me off", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-78400))
    ]
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
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
                    .onChange(of: messages) { _, _ in
                        if let lastMessage = messages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                VStack {
                    Divider().background(Color.gray)
                    HStack(spacing: 12) {
                        TextField("Message", text: $messageText)
                            .padding(12)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(20)
                            .focused($isFocused)
                            .foregroundColor(.white)
                            .disableAutocorrection(true)
                        
                        Button(action: sendMessage) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(messageText.isEmpty ? .gray : .blue)
                                .padding(8)
                                .background(
                                    Circle().fill(messageText.isEmpty ? Color.gray.opacity(0.3) : Color.blue.opacity(0.2))
                                )
                        }
                        .disabled(messageText.isEmpty)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color.black.opacity(0.95))
            }
            .navigationTitle("Group Chat")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let newMessage = Message(
            id: UUID().uuidString,
            sender: "You",
            content: messageText.trimmingCharacters(in: .whitespaces),
            isFromCurrentUser: true,
            timestamp: Date()
        )
        
        withAnimation { messages.append(newMessage) }
        messageText = ""
    }
}

struct Message: Identifiable, Equatable {
    let id: String
    let sender: String
    let content: String
    let isFromCurrentUser: Bool
    let timestamp: Date
}

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isFromCurrentUser { Spacer() }
            
            VStack(alignment: .leading, spacing: 4) {
                if !message.isFromCurrentUser {
                    Text(message.sender)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Text(message.content)
                    .padding(12)
                    .background(message.isFromCurrentUser ? Color.blue : Color.gray.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                Text(formatDate(message.timestamp))
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            if message.isFromCurrentUser { Spacer() }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView(chatParticipants: ["Blaise", "Teo", "Enzo", "Theo"])
    }
}
