//
//  RootView.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 17/6/23.
//  
//

import SwiftUI
import ComposableArchitecture
import CoreUtils

struct FlightSearchView: View {
    //  MARK: - Observed Object
    let store: StoreOf<FlightSearchDomain>
    //  MARK: - Variables
    typealias FlightSearchViewStore = ViewStore<FlightSearchDomain.State, FlightSearchDomain.Action>
    typealias FlightSearchAction = FlightSearchDomain.Action
    //  MARK: - Principal View
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                if viewStore.isLoading {
                    ProgressView()
                } else if viewStore.shouldShowError {
                    ErrorComponent(viewStore)
                } else if viewStore.isSuccess {
                    SearchFormComponent(viewStore)
                } else {
                    ProgressView()
                }
            }
            .animation(.default, value: UUID())
            .sheet(
                isPresented: viewStore.binding(get: \.showFlightResults, send: FlightSearchAction.showFlightResults),
                onDismiss: {

                },
                content: {
                    IfLetStore(
                        store.scope(state: \.flightResultsState, action: FlightSearchAction.flightResults)) { store in
                            FlightResultsView(store: store)
                        }
                })
            .onAppear(perform: { onAppear(viewStore) })
            .onDisappear(perform: onDisappear)
        }
    }
}

//  MARK: - Actions
extension FlightSearchView {
    private func onAppear(_ viewStore: FlightSearchViewStore) {
        viewStore.send(.fetchStations)
    }

    private func onDisappear() {}
}

//  MARK: - Local Components
extension FlightSearchView {
    func ErrorComponent(_ viewStore: FlightSearchViewStore) -> some View {
        VStack {
            Image(systemName: Self.ARRIVAL_IMAGE)
                .font(.system(size: 60))
                .foregroundColor(.red)

            Text(Self.ERROR_MSSG)
                .font(.title.bold())
                .multilineTextAlignment(.center)

            Button {
                viewStore.send(.fetchStations)
            } label: {
                Text(Self.ERROR_BUTTN_TITLE)
                    .font(.body.bold())
                    .foregroundColor(.white)
            }
            .frame(width: 100, height: 45)
            .background(.black)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
            .padding()
        }
        .padding(.horizontal)
    }

    private func SearchFormComponent(_ viewStore: FlightSearchViewStore) -> some View {
        VStack {
            Form {
                TripTypeFormComponent(viewStore)

                TravelSearchFormComponent(viewStore)

                TravelDatesFormComponent(viewStore)

                PassengersFormComponent(viewStore)

                Button(action: {
                    viewStore.send(.showFlightResults(isShowing: true))
                }, label: {
                    Text(Self.LABEL_SEARCH_TXT)
                        .font(.body.bold())
                })
                .frame(maxWidth: .infinity)
                .disabled(viewStore.isSearchButtonDisable)
            }
        }
    }

    private func TripTypeFormComponent(_ viewStore: FlightSearchViewStore) -> some View {
        Section(Self.TRIP_TYPE_TITLE) {
            Picker(selection: viewStore.binding(
                get: \.isRoundTrip,
                send:  FlightSearchAction.roundTrip), label: Text(Self.TRIP_TYPE_TITLE)) {
                    Text(Self.ONE_WAY_TITLE)
                        .tag(false)

                    Text(Self.ROUND_WAY_TITLE)
                        .tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
        }
    }

    private func TravelSearchFormComponent(_ viewStore: FlightSearchViewStore) -> some View {
        Section(Self.TRAVEL_SEARCH_TITLE) {
            Picker(selection: viewStore.binding(
                get: \.fromAirport,
                send:  FlightSearchAction.departAirport), label: Text(Self.FROM_AIR_TITLE)) {
                    Text(Self.SELECT_LABEL).tag("")
                    ForEach(viewStore.airports, id: \.self) { station in
                        Text(station.name)
                            .tag(station.id)
                    }
                }

            Picker(selection: viewStore.binding(
                get: \.toAirport,
                send:  FlightSearchAction.arriveAirport), label: Text(Self.TO_AIR_TITLE)) {
                    Text(Self.SELECT_LABEL).tag("")
                    ForEach(viewStore.airports, id: \.self) { station in
                        Text(station.name)
                            .tag(station.id)
                    }
                }
        }
    }

    private func TravelDatesFormComponent(_ viewStore: FlightSearchViewStore) -> some View {
        Section(Self.TRAVEL_DATE_TITLE) {
            DatePicker(Self.GOING_LABEL, selection: viewStore.binding(
                get: \.departureDate,
                send: FlightSearchAction.departureDate),
                       displayedComponents: .date)

            if !viewStore.isReturnPickerDateDisable {
                DatePicker(Self.RETURN_LABEL, selection: viewStore.binding(
                    get: \.returnDate,
                    send: FlightSearchAction.returnDate),
                           displayedComponents: .date)
            }
        }
    }

    private func PassengersFormComponent(_ viewStore: FlightSearchViewStore) -> some View {
        Section(Self.PASSENGER_TITLE) {
            Stepper("\(Self.ADULT_LABEL): \(viewStore.adults)",
                    value: viewStore.binding(
                        get: \.adults,
                        send: FlightSearchAction.adultCount),
                    in: 1...6)

            Stepper("\(Self.TEEN_LABEL): \(viewStore.teens)",
                    value: viewStore.binding(
                        get: \.teens,
                        send: FlightSearchAction.teenCount),
                    in: 0...6)

            Stepper("\(Self.CHILDREN_LABEL): \(viewStore.childrens)",
                    value: viewStore.binding(
                        get: \.childrens,
                        send: FlightSearchAction.childrenCount),
                    in: 0...6)

        }
    }
}

//  MARK: - Preview
struct FlightSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FlightSearchView(store: FlightSearchView.store)
    }
}
