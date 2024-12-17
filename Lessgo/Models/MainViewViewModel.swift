
import Foundation
import FirebaseFirestore

// MARK: - Plan Model
struct Plan: Identifiable {
    var id: String
    let title: String
    let location: String
    let country: String
    let participants: Int

    // Manual initializer for mapping Firestore data
    init(id: String, data: [String: Any]) {
        self.id = id
        self.title = data["title"] as? String ?? ""
        self.location = data["location"] as? String ?? ""
        self.country = data["country"] as? String ?? ""
        self.participants = data["participants"] as? Int ?? 0
    }
}

class TravelService: ObservableObject {
    private let db = Firestore.firestore()
    @Published var trendingPlans: [Plan] = []
    @Published var userPlans: [Plan] = []

    /// Fetch trending plans
    func fetchTrendingPlans() {
        db.collection("plans")
            .order(by: "participants", descending: true)
            .limit(to: 10)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching trending plans: \(error.localizedDescription)")
                    return
                }

                self.trendingPlans = snapshot?.documents.compactMap { document in
                    Plan(id: document.documentID, data: document.data())
                } ?? []
            }
    }

    /// Fetch user plans
    func fetchUserPlans(for userId: String) {
        db.collection("plans")
            .whereField("userIds", arrayContains: userId)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching user plans: \(error.localizedDescription)")
                    return
                }

                self.userPlans = snapshot?.documents.compactMap { document in
                    Plan(id: document.documentID, data: document.data())
                } ?? []
            }
    }

    /// Add a new plan
    func addPlan(title: String, location: String, country: String, userId: String) {
        let newPlanData: [String: Any] = [
            "title": title,
            "location": location,
            "country": country,
            "participants": 1,
            "userIds": [userId]
        ]

        db.collection("plans").addDocument(data: newPlanData) { error in
            if let error = error {
                print("Error adding new plan: \(error.localizedDescription)")
            }
        }
    }

    /// Update plan participants
    func joinPlan(planId: String, userId: String) {
        let planRef = db.collection("plans").document(planId)

        planRef.updateData([
            "participants": FieldValue.increment(Int64(1)),
            "userIds": FieldValue.arrayUnion([userId])
        ]) { error in
            if let error = error {
                print("Error joining plan: \(error.localizedDescription)")
            }
        }
    }
}
