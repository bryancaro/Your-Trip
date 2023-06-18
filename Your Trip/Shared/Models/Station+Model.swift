//
//  Station+Model.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 17/6/23.
//  
//

import Foundation

/// Response
struct StationResponse: Codable {
    let code, name: String
    let alternateName: String?
    let alias: [String]
    let countryCode, countryName: String
    let countryGroupCode: String
    let countryGroupName: String
    let timeZoneCode, latitude, longitude: String
    let mobileBoardingPass: Bool
    let markets: [MarketResponse]
    let tripCardImageURL: String?
    let airportShopping: Bool?

    enum CodingKeys: String, CodingKey {
        case code, name, alternateName, alias, countryCode, countryName, countryGroupCode, countryGroupName, timeZoneCode, latitude, longitude, mobileBoardingPass, markets
        case tripCardImageURL
        case airportShopping
    }
}

/// Model
struct StationModel: Equatable, Hashable, Identifiable {
    let id: UUID
    let code: String
    let name: String
    let alternateName: String
    let alias: [String]
    let countryCode: String
    let countryName: String
    let countryGroupCode: String
    let countryGroupName: String
    let timeZoneCode: String
    let latitude: String
    let longitude: String
    let mobileBoardingPass: Bool
    let markets: [MarketModel]
    let tripCardImageURL: String
    let airportShopping: Bool

    init(_ response: StationResponse) {
        self.id = UUID()
        self.code = response.code
        self.name = response.name
        self.alternateName = response.alternateName ?? ""
        self.alias = response.alias
        self.countryCode = response.countryCode
        self.countryName = response.countryName
        self.countryGroupCode = response.countryGroupCode
        self.countryGroupName = response.countryGroupName
        self.timeZoneCode = response.timeZoneCode
        self.latitude = response.latitude
        self.longitude = response.longitude
        self.mobileBoardingPass = response.mobileBoardingPass
        self.markets = response.markets.map { MarketModel($0) }
        self.tripCardImageURL = response.tripCardImageURL ?? ""
        self.airportShopping = response.airportShopping ?? false
    }

    init(code: String = "", name: String = "", alternateName: String = "", alias: [String] = [], countryCode: String = "", countryName: String = "", countryGroupCode: String = "", countryGroupName: String = "", timeZoneCode: String = "", latitude: String = "", longitude: String = "", mobileBoardingPass: Bool = false, markets: [MarketModel] = [], tripCardImageURL: String = "", airportShopping: Bool = false) {
        self.id = UUID()
        self.code = code
        self.name = name
        self.alternateName = alternateName
        self.alias = alias
        self.countryCode = countryCode
        self.countryName = countryName
        self.countryGroupCode = countryGroupCode
        self.countryGroupName = countryGroupName
        self.timeZoneCode = timeZoneCode
        self.latitude = latitude
        self.longitude = longitude
        self.mobileBoardingPass = mobileBoardingPass
        self.markets = markets
        self.tripCardImageURL = tripCardImageURL
        self.airportShopping = airportShopping
    }
}

/// Mock
extension StationModel {
    static let empty = Self(name: "Select")

    static let mock = Self(
        code: "AABBCC",
        name: "StationA",
        alternateName: "",
        alias: ["Alias1", "Alias2"],
        countryCode: "US",
        countryName: "United States",
        countryGroupCode: "GroupA",
        countryGroupName: "Group Name",
        timeZoneCode: "PST",
        latitude: "37.7749",
        longitude: "-122.4194",
        mobileBoardingPass: true,
        markets: [MarketModel.mock, MarketModel.mock],
        tripCardImageURL: "",
        airportShopping: false
    )
}

