//
//  NumberFactClient.swift
//  SwiftUITutorial
//
//  Created by YongJin on 9/4/24.
//

import ComposableArchitecture
import Foundation

struct NumberFactClient {
    
    // 종속성 추상화 인터페이스 모델링
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    
    static let liveValue = Self (
        fetch: { number in
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\(number)")!)
            return String(decoding: data, as: UTF8.self)
        }
    )
}

// 구현된 인터페이스를 라이브러리에 등록
extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
