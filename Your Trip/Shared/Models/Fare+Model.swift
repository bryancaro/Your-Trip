//
//  Fare+Model.swift
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

/// Response
struct FareResponse: Codable {
    let fareKey, fareClass: String
    let fares: [FareElementResponse]
}

/// Model
struct FareModel: Equatable, Hashable {
    let fareKey: String
    let fareClass: String
    let fares: [FareElementModel]

    init(_ response: FareResponse) {
        self.fareKey = response.fareKey
        self.fareClass = response.fareClass
        self.fares = response.fares.map { FareElementModel($0) }
    }

    init(fareKey: String = "", fareClass: String = "", fares: [FareElementModel] = []) {
        self.fareKey = fareKey
        self.fareClass = fareClass
        self.fares = fares
    }

    var regularPrice: String {
        let price = fares.first?.amount ?? 0

        let roundValue = round(price * 100) / 100
        return roundValue.toPrice(currency: .USD)
    }
}

/// Mock
extension FareModel {
    static let mock = Self(
        fareKey: "FARE123",
        fareClass: "Economy",
        fares: [FareElementModel.mock, FareElementModel.mock]
    )
}
