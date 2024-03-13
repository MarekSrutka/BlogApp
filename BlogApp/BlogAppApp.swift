//
//  BlogAppApp.swift
//  BlogApp
//
//  Created by Marek Srutka on 13.03.2024.
//

import SwiftUI
import Firebase

@main
struct BlogAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
