//
//  AppFeatureTests.swift
//  SwiftUITutorialTests
//
//  Created by YongJin on 9/5/24.
//

import XCTest
import ComposableArchitecture

@testable import SwiftUITutorial


final class AppFeatureTests: XCTestCase {

    func testIncrementFirstTab() async {
        let store = await TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }

        await store.send(\.tab1.incrementTapped) {
            $0.tab1.count = 1
        }
    }

}
