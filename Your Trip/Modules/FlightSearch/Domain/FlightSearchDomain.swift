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
import Foundation

struct FlightSearchDomain: ReducerProtocol {
    struct State: Equatable {
        /// Data Loading Status
        fileprivate var dataLoadingStatus = DataLoadingStatus.notStarted
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        var isSuccess: Bool {
            dataLoadingStatus == .success
        }

        /// Items Variables
        var airports: [StationModel] = []
        var fromAirport = StationModel()
        var toAirport = StationModel()
        var isRoundTrip = false
        var departureDate = Date()
        var returnDate = Date()
        var adults: Int = 1
        var teens: Int = 0
        var childrens: Int = 0

        /// Properties components
        var isSearchButtonDisable = false
        var isReturnPickerDateDisable: Bool {
            !isRoundTrip
        }
        var showFlightResults = false

        /// Other Components Domain State
        var flightResultsState: FlightResultsDomain.State?
    }

    enum Action: Equatable {
        case fetchStations
        case fetchStationsResponse(TaskResult<StationsModel>)
        case roundTrip(Bool)
        case departAirport(StationModel)
        case arriveAirport(StationModel)
        case departureDate(Date)
        case returnDate(Date)
        case adultCount(Int)
        case teenCount(Int)
        case childrenCount(Int)
        case showFlightResults(isShowing: Bool)
        /// Other Components Domain Actions
        case flightResults(FlightResultsDomain.Action)
    }

    @Dependency(\.FlightSearchServerKey) private var server

    var body: some ReducerProtocol<State, Action> {
        /// Parent logic
        Reduce { state, action in
            switch action {
            case .fetchStations:
                guard (state.dataLoadingStatus == .notStarted || state.dataLoadingStatus == .error) else {
                    return .none
                }

                state.dataLoadingStatus = .loading
                return .run { send in
                    let result = await TaskResult {
                        do {
                            let result = try await server.fetchStations()
                            return result
                        } catch {
                            print(error.localizedDescription)
                            throw error
                        }
                    }

                    await send(.fetchStationsResponse(result))
                }
            case .fetchStationsResponse(let result):
                switch result {
                case .success(let model):
                    state.airports = model.stations
                    state.dataLoadingStatus = .success
                case .failure(let error):
                    print(error.localizedDescription)
                    state.dataLoadingStatus = .error
                }
                return verifyButtonVisibility(state: &state)
            case .roundTrip(let value):
                state.isRoundTrip = value
                return verifyButtonVisibility(state: &state)
            case .departAirport(let airport):
                state.fromAirport = airport
                return verifyButtonVisibility(state: &state)
            case .arriveAirport(let airport):
                state.toAirport = airport
                return verifyButtonVisibility(state: &state)
            case .departureDate(let date):
                state.departureDate = date
                return verifyButtonVisibility(state: &state)
            case .returnDate(let date):
                state.returnDate = date
                return verifyButtonVisibility(state: &state)
            case .adultCount(let count):
                state.adults = count
                return .none
            case .teenCount(let count):
                state.teens = count
                return .none
            case .childrenCount(let count):
                state.childrens = count
                return .none
            case .showFlightResults(let show):
                state.showFlightResults = show
                state.flightResultsState = show ? FlightResultsDomain.State(searchFlight: SearchFlightModel(state: state)) : nil
                return .none
            case .flightResults:
                return .none
            }
        }
        .ifLet(\.flightResultsState, action: /Action.flightResults) {
            FlightResultsDomain()
        }
    }
}

extension FlightSearchDomain {
    private func verifyButtonVisibility(state: inout State) -> EffectTask<Action> {
        let fromAirportCode = state.fromAirport.code
        let toAirportCode = state.toAirport.code
        let isRoundTrip = state.isRoundTrip
        let departureDate = state.departureDate
        let returnDate = state.returnDate

        // Check if the source airport code is empty
        guard !fromAirportCode.isEmpty && !toAirportCode.isEmpty else {
            state.isSearchButtonDisable = true
            return .none
        }

        // Check if the source and destination airport codes are the same
        guard fromAirportCode != toAirportCode else {
            state.isSearchButtonDisable = true
            return .none
        }

        // Check if it's a round trip and the destination airport code is empty
        if isRoundTrip, toAirportCode.isEmpty {
            state.isSearchButtonDisable = true
            return .none
        }

        // Check if the return date is either equal to or after the departure date
        if isRoundTrip {
            let calendar = Calendar.current
            let comparison = calendar.compare(returnDate, to: departureDate, toGranularity: .day)
            if comparison != .orderedSame && comparison != .orderedDescending {
                state.isSearchButtonDisable = true
                return .none
            }
        }

        // Reset the search state
        state.isSearchButtonDisable = false
        return .none
    }
}
