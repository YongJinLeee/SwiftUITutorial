//
//  SwiftUITutorialApp.swift
//  SwiftUITutorial
//
//  Created by YongJin on 2022/08/30.
//
import ComposableArchitecture
import SwiftUI

@main
struct SwiftUITutorialApp: App {
    
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }


    var body: some Scene {
        WindowGroup {
            ContentView()
//            CounterView(store: SwiftUITutorialApp.store)
        }
    }
}
