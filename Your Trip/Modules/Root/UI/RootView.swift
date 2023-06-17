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

struct RootView: View {
    //  MARK: - Observed Object
    let store: StoreOf<RootDomain>
    //  MARK: - Variables
    typealias RootViewStore = ViewStore<RootDomain.State, RootDomain.Action>
    typealias RootAction = RootDomain.Action
    //  MARK: - Principal View
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                CircleComponent(viewStore)
            }
            .onAppear(perform: onAppear)
            .onDisappear(perform: onDisappear)
        }
    }
}

//  MARK: - Actions
extension RootView {
    private func onAppear() {}

    private func onDisappear() {}
}

//  MARK: - Local Components
extension RootView {
    private func CircleComponent(_ viewStore: RootViewStore) -> some View {
        Color.blue
            .frame(width: 50, height: 50)
    }
}

//  MARK: - Preview
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: RootView.store)
    }
}
