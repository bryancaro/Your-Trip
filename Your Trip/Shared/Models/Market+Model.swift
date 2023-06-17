//
//  Market+Model.swift
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
struct MarketResponse: Codable {
    let code: String
    let group: String?
    let stops: [StopResponse]?
    let onlyConnecting, pendingApproval, onlyPrintedBoardingPass: Bool?
}

/// Model
struct MarketModel {
    let code: String
    let group: String
    let stops: [StopModel]
    let onlyConnecting: Bool
    let pendingApproval: Bool
    let onlyPrintedBoardingPass: Bool

    init(_ response: MarketResponse) {
        self.code = response.code
        self.group = response.group ?? ""
        self.stops = response.stops?.map { StopModel($0) } ?? []
        self.onlyConnecting = response.onlyConnecting ?? false
        self.pendingApproval = response.pendingApproval ?? false
        self.onlyPrintedBoardingPass = response.onlyPrintedBoardingPass ?? false
    }

    init(code: String, group: String, stops: [StopModel], onlyConnecting: Bool, pendingApproval: Bool, onlyPrintedBoardingPass: Bool) {
        self.code = code
        self.group = group
        self.stops = stops
        self.onlyConnecting = onlyConnecting
        self.pendingApproval = pendingApproval
        self.onlyPrintedBoardingPass = onlyPrintedBoardingPass
    }
}

/// Mock
extension MarketModel {
    static let mock = Self(
        code: "AABBCC",
        group: "GroupA",
        stops: [StopModel.mock, StopModel.mock],
        onlyConnecting: true,
        pendingApproval: false,
        onlyPrintedBoardingPass: true
    )
}
