//
//  FlightResultsServer.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 18/6/23.
//  
//

import Foundation
import ComposableArchitecture
import CoreNetwork
import CoreUtils

extension DependencyValues {
    var FlightResultsServerKey: FlightResultsServer {
        get { self[FlightResultsServer.self] }
        set { self[FlightResultsServer.self] = newValue }
    }
}

struct FlightResultsServer {
     var fetchFlights: @Sendable(SearchFlightModel) async throws -> FlightsModel
}

extension FlightResultsServer: DependencyKey {
    static var liveValue = Self { data in
        let url = "https://sit-nativeapps.ryanair.com/api/v4/Availability".asURL

        let headers: [String: String] =
        [
            "Content-type": "application/json",
            "client": "ios"
        ]

        let params = data.generateParameters()

        let response: FlightsResponse =
        try await NetworkController
            ._printChanges()
            .request(.get, url: url, headers: headers, params: params, bodyType: .inQuery)

        let model = FlightsModel(response)
        return model
    }

    static var previewValue = Self { value in
        return FlightsModel.mock
    }

    static var testValue = Self { value in
        return FlightsModel.mock
    }
}
