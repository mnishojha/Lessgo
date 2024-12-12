import Foundation
import Firebase
import FirebaseFirestore

// MARK: - Chat Model
struct Chat: Identifiable {
    var id: String
    var name: String
    var lastMessage: String
    var timestamp: Date
}

// MARK: - Recommended Traveler Model
struct Traveler: Identifiable {
    var id: String
    var name: String
    var country: String
    var image: String
    var flag: String
}

// MARK: - ViewModel
class ChatViewModel: ObservableObject {
    @Published var chats: [Chat] = []
    @Published var recommendedTravelers: [Traveler] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let db = Firestore.firestore()
    
    init() {
        fetchChats()
        fetchRecommendedTravelers()
    }
    
    // Fetch Chats from Firestore
    func fetchChats() {
        isLoading = true
        db.collection("chats")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    self.errorMessage = "Failed to fetch chats: \(error.localizedDescription)"
                    self.isLoading = false
                    return
                }
                
                self.chats = snapshot?.documents.compactMap { doc in
                    let data = doc.data() // No need to cast
                    guard let name = data["name"] as? String,
                          let lastMessage = data["lastMessage"] as? String,
                          let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() else {
                        return nil
                    }
                    
                    return Chat(
                        id: doc.documentID,
                        name: name,
                        lastMessage: lastMessage,
                        timestamp: timestamp
                    )
                } ?? []
                self.isLoading = false
            }
    }
    
    // Fetch Recommended Travelers from Firestore
    func fetchRecommendedTravelers() {
        isLoading = true
        db.collection("travelers")
            .getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    self.errorMessage = "Failed to fetch travelers: \(error.localizedDescription)"
                    self.isLoading = false
                    return
                }
                
                self.recommendedTravelers = snapshot?.documents.compactMap { doc in
                    let data = doc.data() // No need to cast
                    guard let name = data["name"] as? String,
                          let country = data["country"] as? String,
                          let image = data["image"] as? String,
                          let flag = data["flag"] as? String else {
                        return nil
                    }
                    
                    return Traveler(
                        id: doc.documentID,
                        name: name,
                        country: country,
                        image: image,
                        flag: flag
                    )
                } ?? []
                self.isLoading = false
            }
    }
    
    // Send a new message
    func sendMessage(to chatId: String, message: String) {
        let data: [String: Any] = [
            "lastMessage": message,
            "timestamp": Timestamp(date: Date())
        ]
        
        db.collection("chats").document(chatId).updateData(data) { error in
            if let error = error {
                self.errorMessage = "Failed to send message: \(error.localizedDescription)"
            }
        }
    }
}
