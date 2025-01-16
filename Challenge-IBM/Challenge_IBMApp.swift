//
//  Challenge_IBMApp.swift
//  Challenge-IBM
//
//  Created by Yonny on 14/01/25.
//

import SwiftUI

@main
struct Challenge_IBMApp: App {
    
    let userDefaultsService = UserDefaultsService()

    var body: some Scene {
        WindowGroup {
            return UnauthenticatedCoordinator().view()
        }
    }
}
