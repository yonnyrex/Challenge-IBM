//
//  UnauthenticatedCoordinator.swift
//  Challenge-IBM
//
//  Created by Yonny on 15/01/25.
//

import SwiftUI
import Stinsen

final class UnauthenticatedCoordinator: NavigationCoordinatable {
    
    // MARK: - NavigationStack
    let stack = NavigationStack(initial: \UnauthenticatedCoordinator.start, false)
    let userDefaultsService = UserDefaultsService()

    // MARK: - Root Definition
    @Root var start = makeStart
    
    // MARK: - Public Methods
    @ViewBuilder
    func makeStart() -> some View {
        LoginView()
    }
    
}
