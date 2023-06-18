//
//  FlightSearch+UIConstants.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 17/6/23.
//  
//

import ComposableArchitecture
import CoreUtils

extension FlightSearchView {
    /// Initial Store
    static let store = Store(
        initialState: FlightSearchDomain.State(),
        reducer: {
            FlightSearchDomain()
                ._printChanges()
        }
    )

    /// Error Message
    static let ERROR_MSSG = "Houston, We Have a Problem!".localized()
    static let ERROR_BUTTN_TITLE = "Retry".localized()

    static let LABEL_SEARCH_TXT = "Search".localized()
    static let TRIP_TYPE_TITLE = "Trip type"
    static let TRIP_TYPE_LABEL = "Trip type"
    static let ONE_WAY_TITLE = "One Way"
    static let ROUND_WAY_TITLE = "Round Trip"
    static let TRAVEL_SEARCH_TITLE = "Travel Search"
    static let FROM_AIR_TITLE = "From Airport"
    static let TO_AIR_TITLE = "To Airport"
    static let SELECT_LABEL = "Select"
    static let TRAVEL_DATE_TITLE = "Travel Dates"
    static let GOING_LABEL = "Going"
    static let RETURN_LABEL = "Return"
    static let PASSENGER_TITLE = "Passengers"
    static let ADULT_LABEL = "Adults"
    static let TEEN_LABEL = "Teens"
    static let CHILDREN_LABEL = "Childrens"
    static let ARRIVAL_IMAGE = "airplane.arrival"
}
