import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth


struct Destinations: Identifiable, Codable {
    @DocumentID var id: String?
    let imageName: String
    let cityName: String
    var imageUrl: String
}

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    let userId: String
    let userName: String
    let title: String
    let content: String
    let timestamp: Date
    let userProfileImageUrl: String?
}


class FirebaseManager: ObservableObject {
    static let shared = FirebaseManager()
    
    @Published var destinations: [Destination] = []
    @Published var posts: [Post] = []
    @Published var currentUser: FirebaseAuth.User?
    @Published var isLoading = false
    @Published var searchResults: [Destination] = []
    
    private let db = Firestore.firestore()
    
    init() {
        setupFirebase()
        
    }
    
    private func setupFirebase() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    
   
    
    
    func fetchDestinations() {
        isLoading = true
        db.collection("destinations")
            .order(by: "popularity", descending: true)
            .limit(to: 10)
            .addSnapshotListener { [weak self] snapshot, error in
                guard (snapshot?.documents) != nil else {
                    print("Error fetching destinations: \(error?.localizedDescription ?? "Unknown error")")
                    self?.isLoading = false
                    return
                }
                
            
                self?.isLoading = false
            }
    }
    
    func searchDestinations(query: String) {
        guard !query.isEmpty else {
            searchResults = []
                return
        }
                
        db.collection("destinations")
            .whereField("cityName", isGreaterThanOrEqualTo: query)
            .whereField("cityName", isLessThanOrEqualTo: query + "\u{f8ff}")
            .getDocuments { snapshot, error in                if let error = error {
                    print("Error searching destinations: \(error.localizedDescription)")
                    return
                }
                
       
    }
    
    // MARK: - Posts
    func fetchPosts() {
        isLoading = true
        db.collection("posts")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching posts: \(error?.localizedDescription ?? "Unknown error")")
                    self?.isLoading = false
                    return
                }
                
                self?.posts = documents.compactMap { try? $0.data(as: Post.self) }
                self?.isLoading = false
            }
    }
    
    func addPost(title: String, content: String) {
        guard let user = currentUser else { return }
        
        let post = Post(
            userId: user.uid,
            userName: user.displayName ?? "Anonymous",
            title: title,
            content: content,
            timestamp: Date(),
            userProfileImageUrl: user.photoURL?.absoluteString
        )
        
        do {
            _ = try db.collection("posts").addDocument(from: post)
        } catch {
            print("Error adding post: \(error.localizedDescription)")
        }
    }
}
            }
