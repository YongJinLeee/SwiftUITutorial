//
//  CounterFeature.swift
//  SwiftUITutorial
//
//  Created by YongJin on 8/29/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        // 변경되는 값을 저장, 방출
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }

    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factResponse(String)
        case factButtonTapped

        // test
        case timerTick
        case toggleTimerButtonTapped
    }

    enum CancelID { case timer }

    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact

    var body: some ReducerOf<Self> {

        Reduce { state, action in
            switch action {

            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none

            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none

            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true

                return .run { [count = state.count] send in
                    try await send(.factResponse(self.numberFact.fetch(count)))
                }

            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none

            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none

            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {

                    return .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: CancelID.timer)
                } else {

                    return .cancel(id: CancelID.timer)
                }
            }
        }
    }
}

struct CounterView: View {
    // 저장소의 변경을 감지하는 상수
    let store: StoreOf<CounterFeature>

    var body: some View {
        VStack {

            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)

            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .foregroundStyle(.black)
                .font(.largeTitle)
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(10)

                Button("+"){
                    store.send(.incrementButtonTapped)
                }
                .foregroundStyle(.black)
                .font(.largeTitle)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

            }

            Button("Fact") {

                store.send(.factButtonTapped)
            }
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)

            if store.isLoading {

                ProgressView()
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State()) {

        CounterFeature()
        }
    )
}
