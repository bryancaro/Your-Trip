//
//  TripCard.swift
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

struct TripCard: View {
    //  MARK: - Variables
    let trip: TripModel
    //  MARK: - Principal View
    var body: some View {
        ZStack {
            VStack {
                FromToComponent

                FlightsComponent

                Divider()
            }
        }
    }
}

//  MARK: - Local Components
extension TripCard {
    private var FromToComponent: some View {
        HStack {
            VStack(alignment: .center, spacing: 5) {
                Image(systemName: Self.DEPART_IMAGE)
                    .font(.system(size: 35))
                    .foregroundColor(.blue)

                Text(trip.origin)
                    .font(.title2.bold())
                    .foregroundColor(.black)
                    .lineLimit(1)
            }
            .padding(.leading, 10)

            Spacer()

            VStack(alignment: .center, spacing: 5) {
                Text(trip.destination)
                    .font(.title2.bold())
                    .foregroundColor(.black)
                    .lineLimit(1)

                Image(systemName: Self.ARRIVAL_IMAGE)
                    .font(.system(size: 35))
                    .foregroundColor(.blue)
            }
            .padding(.trailing, 10)
        }
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
        .padding(.vertical, 10)
    }

    private var FlightsComponent: some View {
        ForEach(trip.dates, id: \.self) { date in
            VStack(alignment: .leading, spacing: 10) {
                ZStack(alignment: .bottomLeading) {
                    Image(Self.BACKGROUND_IMAGE)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 120)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.black)
                                .opacity(0.6)
                        )

                    Text(date.dateOutFormated)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }

                if !date.flights.isEmpty {
                    ForEach(date.flights, id: \.self) { flight in
                        FlightCard(flight: flight)
                    }
                } else {
                    EmptyTrips
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            )
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }

    private var EmptyTrips: some View {
        VStack(spacing: 20) {
            Image(systemName: Self.DEPART_IMAGE)
                .font(.system(size: 30))
                .foregroundColor(.red)

            Text(Self.NO_FLIGHTS_TEXT)
                .font(.body.bold())
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }

}

//  MARK: - Preview
#if DEBUG
struct TripCard_Previews: PreviewProvider {
    static var previews: some View {
        TripCard(trip: .mock)
    }
}
#endif
