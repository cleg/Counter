//
//  CounterTests.swift
//  CounterTests
//
//  Created by Paul Dmitryev on 09.09.2022.
//

import XCTest

@testable import Counter

class CounterTests: XCTestCase {
    func testCounterValueViewModel() throws {
        let simpleDate = Date()
        let dateProviderStub = { simpleDate }
        let expectedInterval: TimeInterval = 1000.0

        let viewModel = CounterValueView.ViewModel(
            currentValue: 10,
            lastChangDate: simpleDate.addingTimeInterval(-expectedInterval),
            onBackTapped: { _ in },
            dateProvider: dateProviderStub
        )

        XCTAssertEqual(viewModel.timeSinceLastChange, expectedInterval)
    }
}
