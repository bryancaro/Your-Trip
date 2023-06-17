//
//  RootServer.swift
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

extension DependencyValues {
    var RootServerKey: RootServer {
        get { self[RootServer.self] }
        set { self[RootServer.self] = newValue }
    }
}

struct RootServer {
    // var fetchProducts: @Sendable () async throws -> [String]
}

extension RootServer: DependencyKey {
    static var liveValue = Self()
        // let url = URL(string: "https://fakestoreapi.com/products")
        // let response: [ProductResponse] = try await NetworkController().request(.get, url: url)
        // let model = response.map({ ProductModel($0) })
        // return model
}
