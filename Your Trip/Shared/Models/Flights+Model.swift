//
//  Flights+Model.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 18/6/23.
//  
//

/// Response
struct FlightsResponse: Codable {
    let currency, serverTimeUTC: String
    let currPrecision: Int
    let trips: [TripResponse]
}

/// Model
struct FlightsModel: Equatable {
    let currency: String
    let serverTimeUTC: String
    let currPrecision: Int
    let trips: [TripModel]

    init(_ response: FlightsResponse) {
        self.currency = response.currency
        self.serverTimeUTC = response.serverTimeUTC
        self.currPrecision = response.currPrecision
        self.trips = response.trips.map { TripModel($0) }
    }

    init(currency: String = "", serverTimeUTC: String = "", currPrecision: Int = 0, trips: [TripModel] = []) {
        self.currency = currency
        self.serverTimeUTC = serverTimeUTC
        self.currPrecision = currPrecision
        self.trips = trips
    }
}

/// Mock
extension FlightsModel {
    static let mock = Self(
        currency: "USD",
        serverTimeUTC: "2023-06-17T10:30:00Z",
        currPrecision: 2,
        trips: [TripModel.mock, TripModel.mock]
    )
}
