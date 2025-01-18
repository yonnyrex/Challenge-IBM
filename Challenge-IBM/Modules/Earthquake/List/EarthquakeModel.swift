//
//  EarthquakeModel.swift
//  Challenge-IBM
//
//  Created by Yonny on 16/01/25.
//

import Foundation

struct EarthquakeResponse: Codable {
    
    let type: String
    let metadata: Metadata
    let features: [EarthquakeFeature]
    
}

struct Metadata: Codable {
    
    let generated: Int
    let url: String
    let title: String
    let status: Int
    let api: String
    let count: Int
    
}

struct EarthquakeFeature: Codable {
    
    let type: String
    let properties: EarthquakeProperties
    let geometry: EarthquakeGeometry
    let id: String
    
}

struct EarthquakeProperties: Codable {

    let title: String
    let magnitude: Double
    let place: String

    enum CodingKeys: String, CodingKey {
        case title
        case magnitude = "mag"
        case place
    }

}

struct EarthquakeGeometry: Codable {
    
    let type: String
    let coordinates: [Double]
    
}

extension EarthquakeResponse {
    
    static func getStubEarthquakeResponse() -> EarthquakeResponse {
        EarthquakeResponse(
            type: "FeatureCollection",
            metadata: Metadata(
                generated: 1577922964240,
                url: "https://earthquake.usgs.gov/fdsnws/event/1/query",
                title: "USGS Earthquake Data",
                status: 200,
                api: "1.10.3",
                count: 2
            ),
            features: [
                EarthquakeFeature(
                    type: "Feature",
                    properties: EarthquakeProperties(
                        title: "M 1.6 - 10km ENE of Blackhawk, CA",
                        magnitude: 1.63,
                        place: "10km ENE of Blackhawk, CA"
                    ),
                    geometry: EarthquakeGeometry(
                        type: "Point",
                        coordinates: [-121.7943333, 37.8455, 12.65]
                    ),
                    id: "nc73322376"
                ),
                EarthquakeFeature(
                    type: "Feature",
                    properties: EarthquakeProperties(
                        title: "M 4.5 - 15km SSW of Volcano, Hawaii",
                        magnitude: 4.5,
                        place: "15km SSW of Volcano, Hawaii"
                    ),
                    geometry: EarthquakeGeometry(
                        type: "Point",
                        coordinates: [-155.292, 19.405, 8.3]
                    ),
                    id: "us7000dflk"
                )
            ]
        )
    }
    
}

enum EarthquakeError: LocalizedError {
    
    case error(message: String)
    
}

extension EarthquakeError {
    
    var errorDescription: String? {
        switch self {
        case .error:
            "EarthquakeError"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .error(let message):
            message
        }
    }
    
}
