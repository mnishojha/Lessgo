import Foundation

struct Destination: Identifiable {
    let id = UUID()
    let name: String
    let region: String
}

let destinationsByRegion: [String: [Destination]] = [
    "North India": [
        Destination(name: "Delhi", region: "North India"),
        Destination(name: "Agra", region: "North India"),
        Destination(name: "Jaipur", region: "North India"),
        Destination(name: "Varanasi", region: "North India"),
        Destination(name: "Amritsar", region: "North India"),
        Destination(name: "Shimla", region: "North India"),
        Destination(name: "Manali", region: "North India"),
        Destination(name: "Rishikesh", region: "North India")
    ],
    "South India": [
        Destination(name: "Bangalore", region: "South India"),
        Destination(name: "Chennai", region: "South India"),
        Destination(name: "Hyderabad", region: "South India"),
        Destination(name: "Kochi", region: "South India"),
        Destination(name: "Mysore", region: "South India"),
        Destination(name: "Ooty", region: "South India"),
        Destination(name: "Munnar", region: "South India"),
        Destination(name: "Hampi", region: "South India")
    ],
    "West India": [
        Destination(name: "Mumbai", region: "West India"),
        Destination(name: "Goa", region: "West India"),
        Destination(name: "Udaipur", region: "West India"),
        Destination(name: "Jodhpur", region: "West India"),
        Destination(name: "Ahmedabad", region: "West India"),
        Destination(name: "Mount Abu", region: "West India"),
        Destination(name: "Pune", region: "West India")
    ],
    "East India": [
        Destination(name: "Kolkata", region: "East India"),
        Destination(name: "Darjeeling", region: "East India"),
        Destination(name: "Gangtok", region: "East India"),
        Destination(name: "Puri", region: "East India"),
        Destination(name: "Shillong", region: "East India"),
        Destination(name: "Kaziranga", region: "East India")
    ],
    "International": [
        Destination(name: "Paris", region: "International"),
        Destination(name: "London", region: "International"),
        Destination(name: "Tokyo", region: "International"),
        Destination(name: "New York", region: "International"),
        Destination(name: "Dubai", region: "International"),
        Destination(name: "Singapore", region: "International")
    ]
]
