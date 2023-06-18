//
//  DateElement+Model.swift
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
struct DateElementResponse: Codable {
    let dateOut: String
    let flights: [FlightResponse]
}

/// Model
struct DateElementModel: Equatable, Hashable {
    let dateOut: String
    let flights: [FlightModel]

    init(_ response: DateElementResponse) {
        self.dateOut = response.dateOut
        self.flights = response.flights.map { FlightModel($0) }
    }

    init(dateOut: String, flights: [FlightModel]) {
        self.dateOut = dateOut
        self.flights = flights
    }

    var dateOutFormated: String {
        dateOut.formatDate() ?? dateOut
    }
}

/// Mock
extension DateElementModel {
    static let mock = Self(
        dateOut: "2023-06-17",
        flights: [FlightModel.mock, FlightModel.mock]
    )
}
