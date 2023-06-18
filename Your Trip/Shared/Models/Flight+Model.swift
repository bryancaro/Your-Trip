//
//  Flight+Model.swift
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
struct FlightResponse: Codable {
    let time: [String]
    let regularFare: FareResponse?
    let faresLeft: Int
    let timeUTC: [String]
    let duration, flightNumber: String
    let infantsLeft: Int
    let flightKey: String
    let businessFare: FareResponse?
}

/// Model
struct FlightModel: Equatable, Hashable {
    let time: [String]
    let regularFare: FareModel
    let faresLeft: Int
    let timeUTC: [String]
    let duration: String
    let flightNumber: String
    let infantsLeft: Int
    let flightKey: String
    let businessFare: FareModel

    init(_ response: FlightResponse) {
        self.time = response.time
        self.faresLeft = response.faresLeft
        self.timeUTC = response.timeUTC
        self.duration = response.duration
        self.flightNumber = response.flightNumber
        self.infantsLeft = response.infantsLeft
        self.flightKey = response.flightKey
        if let regularFare = response.regularFare {
            self.regularFare = FareModel(regularFare)
        } else {
            self.regularFare = FareModel()
        }
        if let businessFare = response.businessFare {
            self.businessFare = FareModel(businessFare)
        } else {
            self.businessFare = FareModel()
        }
    }

    init(time: [String], regularFare: FareModel, faresLeft: Int, timeUTC: [String], duration: String, flightNumber: String, infantsLeft: Int, flightKey: String, businessFare: FareModel) {
        self.time = time
        self.regularFare = regularFare
        self.faresLeft = faresLeft
        self.timeUTC = timeUTC
        self.duration = duration
        self.flightNumber = flightNumber
        self.infantsLeft = infantsLeft
        self.flightKey = flightKey
        self.businessFare = businessFare
    }
}

/// Mock
extension FlightModel {
    static let mock = Self(
        time: ["12:00 PM", "04:00 PM"],
        regularFare: FareModel.mock,
        faresLeft: 5,
        timeUTC: ["19:00", "23:00"],
        duration: "2h 30m",
        flightNumber: "FLIGHT123",
        infantsLeft: 2,
        flightKey: "FLIGHTKEY123",
        businessFare: FareModel.mock
    )
}
