//
//  Root+UIConstants.swift
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

extension RootView {
    /// Initial Store
    static let store = Store(
        initialState: RootDomain.State(),
        reducer: {
            RootDomain()
        }
    )

    /// Navigation Title
    static let NAV_TITLE = ""
}