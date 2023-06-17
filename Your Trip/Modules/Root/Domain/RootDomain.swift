//
//  RootDomain.swift
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

struct RootDomain: ReducerProtocol {
    struct State: Equatable {}

    enum Action: Equatable {}

    @Dependency(\.RootServerKey) private var server

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        return .none
    }
}
