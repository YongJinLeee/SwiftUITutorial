//
//  AppFeature.swift
//  SwiftUITutorial
//
//  Created by YongJin on 9/5/24.
//

import SwiftUI
import ComposableArchitecture

struct AppFeature: View {
    
    let store1 = StoreOf<CounterFeature>
    let store2 = StoreOf<CounterFeature>

    var body: some View {
        TabView {
            CounterView(store: store1)
                .tabItem {
                    Text("Counter 1")
                }

            CounterView(store: store2)
                .tabItem { Text("Counter 2") }
        }

    }
}

#Preview {
    AppFeature()
}
