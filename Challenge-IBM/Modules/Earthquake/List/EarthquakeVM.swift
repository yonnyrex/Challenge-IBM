//
//  EarthquakeVM.swift
//  Challenge-IBM
//
//  Created by Yonny on 16/01/25.
//


import Foundation
import Combine
import Stinsen
import SwiftUI

class EarthquakeVM: ObservableObject {
    
    // MARK: - Propety Wrappers
    @RouterObject var router: AuthenticatedCoordinator.Router?
    @Published var error: EarthquakeError?
    @Published var isLoading = false
    @Published var displayError = false
    @Published var searchText = ""
    @Published var earthquake: [EarthquakeFeature] = []
    @Published var filteredMovies: [EarthquakeFeature] = []

    // MARK: - Variables
    private var earthquakeService: EarthquakeServiceType
    private var cancellables: Set<AnyCancellable> = .init()
    private var userDefaults: PersistenceServiceType
    private var offset = 1
    private let limit = 10

    // MARK: - Initializer
    init(
        earthquakeService: EarthquakeServiceType = EarthquakeService(),
        userDefaults: PersistenceServiceType = UserDefaultsService()
    ) {
        self.earthquakeService = earthquakeService
        self.userDefaults = userDefaults
        setupBindings()
    }
    
    // MARK: - Methods
    func setupBindings() {
        $error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard error != nil else { return }
                self?.displayError = true
            }
            .store(in: &cancellables)
    }
    
    func fetchEarthquake() {
        guard !isLoading else { return }
        isLoading = true
        earthquakeService
            .getEarthquake(limit: limit, offset: offset, startTime: "2020-01-01", endTime: "2020-01-02")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.isLoading = false
                switch result {
                case .failure(let error):
                    self?.error = .error(message: error.message)
                case .finished:
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                earthquake.append(contentsOf: response.features)
                offset += limit
                isLoading = false
            }
            .store(in: &cancellables)
    }

    func goToEarthquakeDetail(eventID: String) {
        self.router?.route(to: \.earthquakeDetail, eventID)
    }
    
    func logOut() {
        self.userDefaults.remove(for: .isLogin)
        self.router?.root(\.unauthenticated)
    }
    
}
