//
//  LessgoApp.swift
//  Lessgo
//
//  Created by manish ojha on 18/10/24.
//

import SwiftUI
import Firebase

@main
struct LessgoApp: App {
    //Initalize Firebase
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            TravelHomeView()
        }
    }
}
