//
//  EarthquakeAPI.swift
//  Challenge-IBM
//
//  Created by Yonny on 17/01/25.
//

import Foundation
import Moya

enum EarthquakeAPI {
    
    case earthquakes(
        limit: Int,
        offset: Int,
        startTime: String,
        endTime: String
    )

    case detail(eventID: String)
    
}

extension EarthquakeAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://earthquake.usgs.gov")!
    }
    
    var path: String {
        switch self {
        case .earthquakes, .detail:
            return "/fdsnws/event/1/query"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .earthquakes, .detail :
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .earthquakes(
            let limit,
            let offset,
            let startTime,
            let endTime
        ):
            let parameters: [String: Any] = [
                "format": "geojson",
                "starttime": startTime,
                "endtime": endTime,
                "limit": limit,
                "offset": offset
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .detail(
            let eventID
        ):
            let parameters: [String: Any] = [
                "format": "geojson",
                "eventid": eventID
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
}
