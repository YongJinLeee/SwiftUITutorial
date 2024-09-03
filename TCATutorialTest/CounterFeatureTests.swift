//
//  CounterFeatureTests.swift
//  CounterFeatureTests
//
//  Created by YongJin on 9/3/24.
//

import XCTest
import ComposableArchitecture

@testable import SwiftUITutorial

final class CounterFeatureTests: XCTestCase {
    

    func testCounter() async {

        let store = await TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
}
