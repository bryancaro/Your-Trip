//
//  RootServer.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 17/6/23.
//  
//

import Foundation
import ComposableArchitecture
import CoreNetwork
import CoreUtils

extension DependencyValues {
    var FlightSearchServerKey: FlightSearchServer {
        get { self[FlightSearchServer.self] }
        set { self[FlightSearchServer.self] = newValue }
    }
}

struct FlightSearchServer {
    var fetchStations: @Sendable() async throws -> StationsModel
}

extension FlightSearchServer: DependencyKey {
    static var liveValue = Self {
        let url = "https://mobile-testassets-dev.s3.eu-west-1.amazonaws.com/stations.json".asURL

        let headers: [String: String] =
        [
            "Content-type": "application/json",
            "client": "ios"
        ]

        let response: StationsResponse = try await NetworkController().request(.get, url: url, headers: headers)
        let model = StationsModel(response)
        return model
    }

    static var testValue = Self {
        let model = StationsModel.mock
        return model
    }

    static var previewValue = Self {
        let model = StationsModel.mock
        return model
    }
}
