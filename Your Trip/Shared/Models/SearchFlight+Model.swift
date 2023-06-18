//
//  SearchFlight+Model.swift
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
import CoreUtils

struct SearchFlightModel: Equatable {
    var from: String
    var to: String
    var isRoundTrip: Bool
    var departureDate: String
    var returnDate: String
    var adults: Int
    var teens: Int
    var childrens: Int

    init(from: String, to: String, isRoundTrip: Bool, departureDate: String, returnDate: String, adults: Int, teens: Int, childrens: Int) {
        self.from = from
        self.to = to
        self.isRoundTrip = isRoundTrip
        self.departureDate = departureDate
        self.returnDate = returnDate
        self.adults = adults
        self.teens = teens
        self.childrens = childrens
    }

    init(state: FlightSearchDomain.State) {
        self.from = state.fromAirport.code
        self.to = state.toAirport.code
        self.isRoundTrip = state.isRoundTrip
        self.departureDate = state.departureDate.toString(format: .customFormat)
        self.returnDate = state.returnDate.toString(format: .customFormat)
        self.adults = state.adults
        self.teens = state.teens
        self.childrens = state.childrens
    }
}

extension SearchFlightModel {
    func generateParameters() -> [String: Any] {
        var parameters: [String: Any] = [
            "origin"            : from,
            "destination"       : to,
            "dateout"           : departureDate,
            "datein"            : returnDate,
            "flexdaysbeforeout" : 3,
            "flexdaysout"       : 3,
            "flexdaysbeforein"  : 3,
            "flexdaysin"        : 3,
            "adt"               : adults,
            "teen"              : teens,
            "chd"               : childrens,
            "roundtrip"         : isRoundTrip,
            "ToUs"              : "AGREED",
            "Disc"              : 0
        ]

        // Remove "datein" parameter if it's not a round trip
        if !isRoundTrip {
            parameters.removeValue(forKey: "datein")
        }

        return parameters
    }
}
