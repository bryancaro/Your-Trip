//
//  Stop+Model.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 17/6/23.
//  
//

/// Response
struct StopResponse: Codable {
    let code: String
}

/// Model
struct StopModel: Equatable, Hashable {
    let code: String

    init(_ response: StopResponse) {
        self.code = response.code
    }

    init(code: String) {
        self.code = code
    }
}

/// Mock
extension StopModel {
    static let mock = Self(code: "AABBCC")
}
