//
//  FlightResultsDomain_Test.swift
//  Your TripTests
//
//  Created by Bryan Caro on 19/6/23.
//

import XCTest
import ComposableArchitecture
import Combine

@testable import Your_Trip

@MainActor
final class FlightResultsDomain_Test: XCTestCase {
    enum TestError: Error {
        case genericError
    }

    func test_fetchFlights_notStarted_shouldSetDataLoadingStatusAndFetchSuccess() async {
        // Prepare the search flight model with appropriate data
        let searchFlight = SearchFlightModel(
            from: "New York",
            to: "Los Angeles",
            isRoundTrip: true,
            departureDate: "2023-07-01",
            returnDate: "2023-07-10",
            adults: 2,
            teens: 1,
            childrens: 0)

        // Create the test store with initial state and dependencies
        let store = TestStore(
            initialState: FlightResultsDomain.State(searchFlight: searchFlight)
        ) {
            FlightResultsDomain()
        } withDependencies: {
            $0.FlightResultsServerKey = .testValue
        }

        // Provide a mock result for fetching flights
        let expectResult = FlightsModel.mock

        // Simulate the `fetchFlights` action and verify the expected state changes
        await store.send(.fetchFlights) {
            $0.dataLoadingStatus = .loading
        }

        // Simulate receiving the `fetchFlightsResponse` action with a success result
        await store.receive(.fetchFlightsResponse(.success(expectResult))) {
            $0.dataLoadingStatus = .success
            $0.flight = expectResult
        }
    }

    func test_fetchFlights_error_shouldNotFetchFlights() async {
        // Prepare the search flight model with appropriate data
        let searchFlight = SearchFlightModel(
            from: "New York",
            to: "Los Angeles",
            isRoundTrip: true,
            departureDate: "2023-07-01",
            returnDate: "2023-07-10",
            adults: 2,
            teens: 1,
            childrens: 0)

        // Create the test store with initial state and dependencies
        let store = TestStore(
            initialState: FlightResultsDomain.State(searchFlight: searchFlight)
        ) {
            FlightResultsDomain()
        } withDependencies: {
            // Simulate a failure when fetching flights by throwing a generic error
            $0.FlightResultsServerKey.fetchFlights = { value in
                throw TestError.genericError
            }
        }

        // Simulate the `fetchFlights` action and verify the expected state changes
        await store.send(.fetchFlights) {
            $0.dataLoadingStatus = .loading
        }

        // Simulate receiving the `fetchFlightsResponse` action with a failure result
        await store.receive(.fetchFlightsResponse(.failure(TestError.genericError))) {
            $0.dataLoadingStatus = .error
            $0.flight = FlightsModel()
        }

        // No changes expected since the data loading status is error
        // Add assertions if needed
    }

    func test_fetchFlightsResponse_success_shouldUpdateDataLoadingStatusAndFlight() async {
        // Prepare the search flight model with appropriate data
        let searchFlight = SearchFlightModel(
            from: "New York",
            to: "Los Angeles",
            isRoundTrip: true,
            departureDate: "2023-07-01",
            returnDate: "2023-07-10",
            adults: 2,
            teens: 1,
            childrens: 0)

        // Create the test store with initial state and dependencies
        let store = TestStore(
            initialState: FlightResultsDomain.State(searchFlight: searchFlight)
        ) {
            FlightResultsDomain()
        } withDependencies: {
            $0.FlightResultsServerKey = .testValue
        }

        // Provide a mock result for fetching flights
        let expectResult = FlightsModel.mock

        // Simulate receiving the `fetchFlightsResponse` action with a success result
        await store.send(.fetchFlightsResponse(.success(expectResult))) {
            $0.dataLoadingStatus = .success
            $0.flight = expectResult
        }
    }
}
