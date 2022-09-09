//
//  DateView.swift
//  Counter
//
//  Created by Paul Dmitryev on 09.09.2022.
//

import SwiftUI

///
/// Simple views can be actually self-contained. In this case, we're isolating this details from
/// parent view, and we don't have to create some intermediate entity to pass parameters
/// 
struct DateView: View {
    let dateChanged: Date
    let onBackTapped: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Text("\(dateChanged)")

            Button(action: onBackTapped) {
                Text("Go back")
            }
        }
    }
}
