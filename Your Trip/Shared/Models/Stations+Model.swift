//
//  Stations+Model.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 17/6/23.
//  
//

/// Response
struct StationsResponse: Codable {
    let stations: [StationResponse]
}

/// Model
struct StationsModel: Equatable {
    let stations: [StationModel]

    init(_ response: StationsResponse) {
        self.stations = response.stations.map { StationModel($0) }
    }

    init(stations: [StationModel]) {
        self.stations = stations
    }
}

/// Mock
extension StationsModel {
    static let mock = Self(stations: [StationModel.mock, StationModel.mock])
}
