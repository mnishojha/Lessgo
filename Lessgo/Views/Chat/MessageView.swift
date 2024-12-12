import SwiftUI

struct ChatDetailView: View {
    @State private var messageText = ""
    @State private var messages: [Message] = [
        Message(text: "Can I call you back later?", isSentByMe: true),
        Message(text: "Sure!!!!", isSentByMe: false)
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                ChatHeaderView(name: "Manish")
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(messages) { message in
                            MessageBubbleView(message: message)
                        }
                    }
                    .padding()
                }
                
                MessageInputView(messageText: $messageText, onSend: sendMessage)
            }
        }
        .foregroundColor(.white)
    }
    
    // Function to send a message
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        let newMessage = Message(text: messageText, isSentByMe: true)
        messages.append(newMessage)
        messageText = ""
    }
}


struct ChatHeaderView: View {
    let name: String
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(name)
                    .foregroundColor(.white)
                    .font(.headline)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "phone.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.15))
    }
}


struct MessageBubbleView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isSentByMe {
                Spacer()
            }
            
            Text(message.text)
                .padding()
                .background(message.isSentByMe ? Color.blue : Color.green)
                .foregroundColor(.white)
                .cornerRadius(20)
                .frame(maxWidth: .infinity, alignment: message.isSentByMe ? .trailing : .leading)
            
            if !message.isSentByMe {
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}


struct MessageInputView: View {
    @Binding var messageText: String
    var onSend: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            
            TextField("Message", text: $messageText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(20)
            
            Button(action: onSend) {
                Image(systemName: "paperplane.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
}


struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isSentByMe: Bool
}


struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailView()
            .preferredColorScheme(.dark)
    }
}
