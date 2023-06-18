//
//  Trip+Model.swift
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
struct TripResponse: Codable {
    let origin, destination: String
    let dates: [DateElementResponse]
}

/// Model
struct TripModel: Equatable, Hashable {
    let origin: String
    let destination: String
    let dates: [DateElementModel]

    init(_ response: TripResponse) {
        self.origin = response.origin
        self.destination = response.destination
        self.dates = response.dates.map { DateElementModel($0) }
    }

    init(origin: String, destination: String, dates: [DateElementModel]) {
        self.origin = origin
        self.destination = destination
        self.dates = dates
    }
}

/// Mock
extension TripModel {
    static let mock = Self(
        origin: "New York",
        destination: "London",
        dates: [DateElementModel.mock, DateElementModel.mock]
    )
}
