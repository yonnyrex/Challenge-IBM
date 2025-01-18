//
//  EarthquakeDetailVM.swift
//  Challenge-IBM
//
//  Created by Yonny on 18/01/25.
//

import Foundation
import Combine
import Stinsen
import SwiftUI

class EarthquakeDetailVM: ObservableObject {
    
    // MARK: - Propety Wrappers
    @RouterObject var router: AuthenticatedCoordinator.Router?
    @Published var error: EarthquakeError?
    @Published var isLoading = false
    @Published var displayError = false
    @Published var earthquake: EarthquakeFeature?

    // MARK: - Variables
    private var earthquakeService: EarthquakeServiceType
    private var cancellables: Set<AnyCancellable> = .init()
    private var userDefaults: PersistenceServiceType
    private var eventID: String

    // MARK: - Initializer
    init(
        earthquakeService: EarthquakeServiceType = EarthquakeService(),
        userDefaults: PersistenceServiceType = UserDefaultsService(),
        eventID: String
    ) {
        self.earthquakeService = earthquakeService
        self.userDefaults = userDefaults
        self.eventID = eventID
        setupBindings()
        getDetailEarthquake()
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
    
    func getDetailEarthquake() {
        guard !isLoading else { return }
        isLoading = true
        earthquakeService
            .getEarthquakeDetail(eventID: eventID)
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
                earthquake = response
                isLoading = false
            }
            .store(in: &cancellables)
    }

    func popLast() {
        router?.popLast()
    }
    
}
