//
//  NumberFactClient.swift
//  SwiftUITutorial
//
//  Created by YongJin on 9/4/24.
//

import ComposableArchitecture

struct NumberFactClient {

    var fetch: (Int) async throws -> String
}
