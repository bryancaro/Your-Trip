//
//  FlightCard.swift
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

struct FlightCard: View {
    //  MARK: - Observed Object
    //  MARK: - Variables
    let flight: FlightModel
    //  MARK: - Principal View
    var body: some View {
        ZStack {
            HStack(spacing: 20) {
                Image(systemName: Self.PLANE_IMAGE)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.blue)

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(Self.FLIGHT_NUMBER_LABEL) \(flight.flightNumber)")
                        .font(.headline)

                    HStack {
                        Text(Self.PRICE_LABEL)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text(flight.regularFare.regularPrice)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 8)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color(.secondarySystemBackground))
            )
            .padding(.vertical, 4)
            .padding(.horizontal)
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
}

//  MARK: - Actions
extension FlightCard {
    private func onAppear() {}
    
    private func onDisappear() {}
}

//  MARK: - Local Components
extension FlightCard {}

//  MARK: - Preview
struct FlightCard_Previews: PreviewProvider {
    static var previews: some View {
        FlightCard(flight: .mock)
    }
}

