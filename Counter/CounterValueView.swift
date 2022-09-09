//
//  CounterValueView.swift
//  Counter
//
//  Created by Paul Dmitryev on 09.09.2022.
//

import SwiftUI

struct CounterValueView: View {
    class ViewModel: ObservableObject {
        let currentValue: UInt
        let timeSinceLastChange: TimeInterval
        let onBackTapped: (Bool) -> Void

        /// Actually, I don't think there is some need to pass callback to view model if it's
        /// operated by view. It's simpler to hold it inside of view in simple cases (I prefer this
        /// option), and use coordinator in a more complicated scenarios. But it's not that
        /// important, so I'm using view model as an "intermediate storage" for callback
        init(
            currentValue: UInt,
            lastChangDate: Date,
            onBackTapped: @escaping (Bool) -> Void,
            // Simple trick to test date-related things with a repeatable results
            dateProvider: @escaping (() -> Date) = { Date() }
        ) {
            self.currentValue = currentValue
            self.timeSinceLastChange = dateProvider().timeIntervalSince(lastChangDate)
            self.onBackTapped = onBackTapped
        }

        func goBack(andResetCounter reset: Bool) {
            onBackTapped(reset)
        }
    }

    @StateObject private var viewModel: ViewModel

    init(currentValue: UInt, lastChangDate: Date, onBackTapped: @escaping (Bool) -> Void) {
        self._viewModel = .init(wrappedValue: .init(
            currentValue: currentValue,
            lastChangDate: lastChangDate,
            onBackTapped: onBackTapped
        ))
    }

    var body: some View {
        VStack(spacing: 32.0) {
            Spacer()
            Text("Counter value: \(viewModel.currentValue)")
            Text("Since last change: \(viewModel.timeSinceLastChange)")
            Spacer(minLength: 32.0)
            Button("Back and reset") {
                viewModel.goBack(andResetCounter: true)
            }
            Button("Just back") {
                viewModel.goBack(andResetCounter: false)
            }
            Spacer()
        }
    }
}
