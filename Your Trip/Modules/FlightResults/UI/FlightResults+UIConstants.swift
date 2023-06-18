//
//  FlightResults+UIConstants.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 18/6/23.
//  
//

import ComposableArchitecture
import CoreUtils

extension FlightResultsView {
    /// Initial Store
    static let store = Store(
        initialState: FlightResultsDomain.State(searchFlight: SearchFlightModel(state: FlightSearchDomain.State())),
        reducer: {
            FlightResultsDomain()
        }
    )

    /// Navigation Title
    static let NAV_TITLE = ""

    /// Error Message
    static let ERROR_MSSG = "Houston, We Have a Problem!".localized()
    static let ERROR_BUTTN_TITLE = "Retry".localized()
    static let ERROR_IMAGE = "airplane.arrival"

    static let IMAGE_PEOPLE = "person.circle"
    static let ADULT_LABEL = "Adults"
    static let TEEN_LABEL = "Teens"
    static let CHILDREN_LABEL = "Childrens"
}
