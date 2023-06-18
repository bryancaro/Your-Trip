//
//  FlightResultsView.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 18/6/23.
//  
//

import SwiftUI
import ComposableArchitecture

struct FlightResultsView: View {
    //  MARK: - Observed Object
    let store: StoreOf<FlightResultsDomain>
    //  MARK: - Variables
    typealias FlightResultsViewStore = ViewStore<FlightResultsDomain.State, FlightResultsDomain.Action>
    typealias FlightResultsAction = FlightResultsDomain.Action
    //  MARK: - Principal View
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                if viewStore.isLoading {
                    ProgressView()
                } else if viewStore.shouldShowError {
                    ErrorComponent(viewStore)
                } else if viewStore.isSuccess {
                    TripsComponent(viewStore)
                } else {
                    ProgressView()
                }
            }
            .animation(.default, value: UUID())
            .onAppear(perform: { onAppear(viewStore) })
            .onDisappear(perform: onDisappear)
        }
    }
}

//  MARK: - Actions
extension FlightResultsView {
    private func onAppear(_ viewStore: FlightResultsViewStore) {
        viewStore.send(.fetchFlights)
    }

    private func onDisappear() {}
}

//  MARK: - Local Components
extension FlightResultsView {
    func ErrorComponent(_ viewStore: FlightResultsViewStore) -> some View {
        VStack {
            Image(systemName: Self.ERROR_IMAGE)
                .font(.system(size: 60))
                .foregroundColor(.red)

            Text(Self.ERROR_MSSG)
                .font(.title.bold())
                .multilineTextAlignment(.center)

            Button {
                viewStore.send(.fetchFlights)
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

    func PersonsComponent(_ viewStore: FlightResultsViewStore) -> some View {
        HStack(spacing: 10) {
            Spacer()

            VStack {
                Image(systemName: Self.IMAGE_PEOPLE)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .colorMultiply(.gray)

                Text(Self.ADULT_LABEL)
                    .font(.body.bold())
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .opacity(0.8)
                Text("\(viewStore.searchFlight.adults)")
                    .font(.footnote.bold())
            }

            Spacer()

            VStack {
                Image(systemName: Self.IMAGE_PEOPLE)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .colorMultiply(.gray)

                Text(Self.TEEN_LABEL)
                    .font(.body.bold())
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .opacity(0.8)

                Text("\(viewStore.searchFlight.teens)")
                    .font(.footnote.bold())
            }

            Spacer()

            VStack {
                Image(systemName: Self.IMAGE_PEOPLE)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .colorMultiply(.gray)

                Text(Self.CHILDREN_LABEL)
                    .font(.body.bold())
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .opacity(0.8)

                Text("\(viewStore.searchFlight.childrens)")
                    .font(.footnote.bold())
            }

            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }

    func TripsComponent(_ viewStore: FlightResultsViewStore) -> some View {
        ScrollView {
            Spacer()
                .frame(height: 50)

            PersonsComponent(viewStore)

            ForEach(viewStore.flight.trips, id: \.self) { trip in
                TripCard(trip: trip)
            }
        }
    }
}

//  MARK: - Preview
struct FlightResultsView_Previews: PreviewProvider {
    static var previews: some View {
        FlightResultsView(store: FlightResultsView.store)
    }
}
