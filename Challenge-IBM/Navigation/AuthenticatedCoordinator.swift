//
//  AuthenticatedCoordinator.swift
//  Challenge-IBM
//
//  Created by Yonny on 16/01/25.
//

import SwiftUI
import Stinsen

final class AuthenticatedCoordinator: NavigationCoordinatable {
    
    // MARK: - NavigationStack
    let stack = NavigationStack(initial: \AuthenticatedCoordinator.start, false)
    
    // MARK: - Root Definition
    @Root var start = makeStart
    
    // MARK: - Routes
    @Route(.push) var earthquakeDetail = makeEarthquakeDetail

    @Root var unauthenticated = unauthenticatedCoordinator

    // MARK: - Public Methods
    @ViewBuilder
    func makeStart() -> some View {
        EarthquakeView()
    }
    
    @ViewBuilder
    func makeEarthquakeDetail(eventID: String) -> some View {
        EarthquakeDetailView(viewModel: EarthquakeDetailVM(eventID: eventID))
    }
    
    func unauthenticatedCoordinator() -> NavigationViewCoordinator<UnauthenticatedCoordinator> {
        UnauthenticatedCoordinator().eraseToNavigationCoordinator()
    }
    
    
}

