//
//  FlightSearchDomain_Test.swift
//  Your TripTests
//
//  Created by Bryan Caro on 18/6/23.
//

import XCTest
import ComposableArchitecture
import Combine

@testable import Your_Trip

@MainActor
final class FlightSearchDomain_Test: XCTestCase {
    enum TestError: Error {
        case genericError
    }

    // Test case: Fetch stations when not started - should set data loading status and fetch successfully
    func test_fetchStations_notStarted_shouldSetDataLoadingStatusAndFetchSuccess() async {
        let store = TestStore(
            initialState: FlightSearchDomain.State()) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        let expectResult = StationsModel.mock

        await store.send(.fetchStations) {
            $0.dataLoadingStatus = .loading
        }

        await store.receive(.fetchStationsResponse(.success(expectResult))) {
            $0.airports = expectResult.stations
            $0.dataLoadingStatus = .success
        }

        await store.receive(.getSearchButtonStatus) {
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Fetch stations when not started - should set data error status and fetch failure
    func test_fetchStations_notStarted_shouldSetDataErrorStatusAndFetchFailure() async {
        let expectResult = TestError.genericError

        let store = TestStore(
            initialState: FlightSearchDomain.State()) {
                FlightSearchDomain()
            }  withDependencies: {
                $0.FlightSearchServerKey.fetchStations = { throw expectResult }
            }

        await store.send(.fetchStations) {
            $0.dataLoadingStatus = .loading
        }

        await store.receive(.fetchStationsResponse(.failure(expectResult))) {
            $0.airports = [StationModel]()
            $0.dataLoadingStatus = .error
        }

        await store.receive(.getSearchButtonStatus) {
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Toggle round trip - should update isRoundTrip
    func test_roundTripToggle_shouldUpdateIsRoundTrip() async {
        let store = TestStore(
            initialState: FlightSearchDomain.State()) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        let expectResult = true

        await store.send(.roundTrip(expectResult)) {
            $0.isRoundTrip = true
        }

        await store.receive(.getSearchButtonStatus) {
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Depart airport selection - should update fromAirport
    func test_departAirportSelection_shouldUpdateFromAirport() async {
        let store = TestStore(
            initialState: FlightSearchDomain.State()) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        let departAirportSelected = StationModel.mock

        await store.send(.departAirport(departAirportSelected)) {
            $0.fromAirport = departAirportSelected
        }

        await store.receive(.getSearchButtonStatus) {
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Arrive airport selection - should update toAirport
    func test_arriveAirportSelection_shouldUpdateToAirport() async {
        let store = TestStore(
            initialState: FlightSearchDomain.State()) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        let arriveAirportSelected = StationModel.mock

        await store.send(.arriveAirport(arriveAirportSelected)) {
            $0.toAirport = arriveAirportSelected
        }

        await store.receive(.getSearchButtonStatus) {
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Departure date selection - should update departureDate
    func test_departureDateSelection_shouldUpdateDepartureDate() async {
        let store = TestStore(
            initialState: FlightSearchDomain.State()) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        let departureDateSelected = convertStringToDate("2023-06-30")

        await store.send(.departureDate(departureDateSelected)) {
            $0.departureDate = departureDateSelected
        }

        await store.receive(.getSearchButtonStatus) {
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Return date selection - should update returnDate
    func test_returnDateSelection_shouldUpdateReturnDate() async {
        let store = TestStore(
            initialState: FlightSearchDomain.State()) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        let returnDateSelected = convertStringToDate("2023-06-30")

        await store.send(.returnDate(returnDateSelected)) {
            $0.returnDate = returnDateSelected
        }

        await store.receive(.getSearchButtonStatus) {
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Adult count selection - should update adults
    func test_adultCount_shouldUpdateAdults() async {
        let store = TestStore(
            initialState: FlightSearchDomain.State()) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        let adultCount = 3

        await store.send(.adultCount(adultCount)) {
            $0.adults = adultCount
        }
    }

    // Test case: Teen count selection - should update teens
    func test_teenCount_shouldUpdateTeens() async {
        let store = TestStore(
            initialState: FlightSearchDomain.State()) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        let teensCount = 3

        await store.send(.teenCount(teensCount)) {
            $0.teens = teensCount
        }
    }

    // Test case: Children count selection - should update childrens
    func test_childrenCount_shouldUpdateChildrens() async {
        let store = TestStore(
            initialState: FlightSearchDomain.State()) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        let childrensCount = 3

        await store.send(.childrenCount(childrensCount)) {
            $0.childrens = childrensCount
        }
    }

    // Test case: Verify button visibility with empty airport codes - should disable search button
    func test_verifyButtonVisibility_emptyAirportCodes_shouldDisableSearchButton() async {
        let store = TestStore(
            initialState: FlightSearchDomain.State(
                airports: [StationModel]()
            )) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        await store.send(.getSearchButtonStatus) {
            $0.airports = [StationModel]()
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Verify button visibility with same airport codes - should disable search button
    func test_verifyButtonVisibility_sameAirportCodes_shouldDisableSearchButton() async {
        let fromAirport = StationModel.mock
        let toAirport = StationModel.mock

        let store = TestStore(
            initialState: FlightSearchDomain.State(
                fromAirport: fromAirport,
                toAirport: toAirport
            )) {
                FlightSearchDomain()
            } withDependencies: {
                $0.FlightSearchServerKey = .testValue
            }

        await store.send(.getSearchButtonStatus) {
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Verify button visibility with round trip and empty destination code - should disable search button
    func test_verifyButtonVisibility_roundTripEmptyDestinationCode_shouldDisableSearchButton() async {
        let fromAirport = StationModel.mock
        let toAirport = StationModel()

        let store = TestStore(
            initialState: FlightSearchDomain.State(
                dataLoadingStatus: .success,
                airports: [StationModel.mock],
                fromAirport: fromAirport,
                toAirport: toAirport,
                isRoundTrip: true,
                departureDate: Date())) {
                    FlightSearchDomain()
                } withDependencies: {
                    $0.FlightSearchServerKey = .testValue
                }

        await store.send(.getSearchButtonStatus) {
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Verify button visibility with invalid return date - should disable search button
    func test_verifyButtonVisibility_invalidReturnDate_shouldDisableSearchButton() async {
        let fromAirport = StationModel.mock
        let toAirport = StationModel(code: "COL")
        let departureDate = convertStringToDate("2023-06-30")
        let returnDate = convertStringToDate("2023-05-30")

        let store = TestStore(
            initialState: FlightSearchDomain.State(
                dataLoadingStatus: .success,
                airports: [StationModel.mock],
                fromAirport: fromAirport,
                toAirport: toAirport,
                isRoundTrip: true,
                departureDate: departureDate,
                returnDate: returnDate
            )
        ) {
            FlightSearchDomain()
        } withDependencies: {
            $0.FlightSearchServerKey = .testValue
        }

        await store.send(.getSearchButtonStatus) {
            $0.isSearchButtonDisable = true
        }
    }

    // Test case: Verify button visibility with valid conditions - should enable search button
    func test_verifyButtonVisibility_validConditions_shouldEnableSearchButton() async {
        let isRoundTrip = true
        let fromAirport = StationModel(code: "MAD")
        let toAirport = StationModel(code: "COL")
        let departureDate = convertStringToDate("2050-01-5")
        let returnDate = convertStringToDate("2050-01-25")

        let store = TestStore(
            initialState: FlightSearchDomain.State(
                dataLoadingStatus: .success,
                airports: [StationModel.mock],
                fromAirport: fromAirport,
                toAirport: toAirport,
                isRoundTrip: isRoundTrip,
                departureDate: departureDate,
                returnDate: returnDate,
                adults: 1
            )
        ) {
            FlightSearchDomain()
        } withDependencies: {
            $0.FlightSearchServerKey = .testValue
        }

        await store.send(.getSearchButtonStatus) ///    No changes occurred, isSearchButtonDisable is enabled
    }
}

// Helper function to convert a string to a date
extension FlightSearchDomain_Test {
    func convertStringToDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)!
    }
}
