//
//  AppFeature.swift
//  SwiftUITutorial
//
//  Created by YongJin on 9/5/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppFeature {


    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
    }

    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
    }

    var body: some ReducerOf<Self> {
        
        // 부모 리듀서 상속 및 자식 리듀서 실행

        Scope(state: \.tab1, action: \.tab1) {
            CounterFeature()
        }

        Scope(state: \.tab2, action: \.tab2) {
            CounterFeature()
        }

        Reduce { state, action  in

            return .none
        }
    }
}

struct AppView: View {

    let store: StoreOf<AppFeature>

    var body: some View {
        TabView {
            CounterView(store: store.scope(state: \.tab1, action: \.tab1))
                .tabItem { Text("Counter 1") }

            CounterView(store: store.scope(state: \.tab2, action: \.tab2))
                .tabItem { Text("Counter 2") }
        }
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State(), reducer: {
        AppFeature()
    }))
}

