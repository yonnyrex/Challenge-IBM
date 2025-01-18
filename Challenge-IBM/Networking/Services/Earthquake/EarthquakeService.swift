//
//  EarthquakeService.swift
//  Challenge-IBM
//
//  Created by Yonny on 17/01/25.
//

import Foundation
import Combine

protocol EarthquakeServiceType {

    func getEarthquake(
        limit: Int,
        offset: Int,
        startTime: String,
        endTime: String
    ) -> AnyPublisher<EarthquakeResponse, ServiceError>
    
    func getEarthquakeDetail(
        eventID: String
    ) -> AnyPublisher<EarthquakeFeature, ServiceError>
}

struct EarthquakeService: EarthquakeServiceType {

    // MARK: - Variables
    private let provider: NetworkServiceType
    
    // MARK: - Initializer
    init(provider: NetworkServiceType = NetworkService()) {
        self.provider = provider
    }

    // MARK: - Methods
    
    func getEarthquake(limit: Int, offset: Int, startTime: String, endTime: String) -> AnyPublisher<EarthquakeResponse, ServiceError> {
        provider.execute(
            request: EarthquakeAPI.earthquakes(
                limit: limit,
                offset: offset,
                startTime: startTime,
                endTime: endTime
            )
        )
    }
    
    func getEarthquakeDetail(eventID: String) -> AnyPublisher<EarthquakeFeature, ServiceError> {
        provider.execute(
            request: EarthquakeAPI.detail(
                eventID: eventID
            )
        )
    }
    
}
