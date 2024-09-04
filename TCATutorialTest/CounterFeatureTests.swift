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

    func testTimer() async {
        let clock = TestClock()

        let store = await TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }

        // 타이머 테스트 토글 시작
        await store.send(.toggleTimerButtonTapped) {

            $0.isTimerRunning = true
        }
        // 기준 시간마다 카운트 증가
        await store.receive(\.timerTick, timeout: .seconds(2)) {
            $0.count = 1
        }
        /// 타이머 토글 명시적 종료 시점 알림
        ///     - 시점을 명시하지 않으면 XCTest가 타임아웃 실패로 처리

        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }

    // 서버 응답값이 항상 다르게 오기때문에 테스트 성공 케이스를 특정할 수 없음을 증명함
    func testNumberFact() async {

        let store = await TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }

        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }

        await store.send(.factButtonTapped) {

            $0.isLoading = false
        }
    }
}
