//
//  FlightResultsDomain.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 18/6/23.
//  
//

import ComposableArchitecture

struct FlightResultsDomain: ReducerProtocol {
    struct State: Equatable {
        /// Data Loading Status
        var dataLoadingStatus = DataLoadingStatus.notStarted
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
        let searchFlight: SearchFlightModel
        var flight = FlightsModel()
    }

    enum Action: Equatable {
        case fetchFlights
        case fetchFlightsResponse(TaskResult<FlightsModel>)
    }

    @Dependency(\.FlightResultsServerKey) private var server

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchFlights:
            let data = state.searchFlight
            state.dataLoadingStatus = .loading

            return .run { send in
                let result = await TaskResult {
                    do {
                        let result = try await server.fetchFlights(data)
                        return result
                    } catch {
                        print(error.localizedDescription)
                        throw error
                    }
                }

                await send(.fetchFlightsResponse(result))
            }
        case .fetchFlightsResponse(let result):
            switch result {
            case .success(let model):
                state.dataLoadingStatus = .success
                state.flight = model
            case .failure(let error):
                print(error.localizedDescription)
                state.dataLoadingStatus = .error
            }
            return .none
        }
    }
}
