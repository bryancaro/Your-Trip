//
//  FareElement+Model.swift
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
struct FareElementResponse: Codable {
    let amount: Double
    let count: Int
    let type: String
    let hasDiscount: Bool
    let publishedFare: Double
}

/// Model
struct FareElementModel: Equatable, Hashable {
    let amount: Double
    let count: Int
    let type: String
    let hasDiscount: Bool
    let publishedFare: Double

    init(_ response: FareElementResponse) {
        self.amount = response.amount
        self.count = response.count
        self.type = response.type
        self.hasDiscount = response.hasDiscount
        self.publishedFare = response.publishedFare
    }

    init(amount: Double, count: Int, type: String, hasDiscount: Bool, publishedFare: Double) {
        self.amount = amount
        self.count = count
        self.type = type
        self.hasDiscount = hasDiscount
        self.publishedFare = publishedFare
    }
}

/// Mock
extension FareElementModel {
    static let mock = Self(amount: 100.0, count: 2, type: "Economy", hasDiscount: true, publishedFare: 150.0)
}
