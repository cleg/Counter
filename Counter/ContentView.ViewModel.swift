//
//  ContentView.ViewModel.swift
//  Counter
//
//  Created by Paul Dmitryev on 09.09.2022.
//

import Foundation

extension ContentView {
    class ViewModel: ObservableObject {
        /// I'm not making callbacks part of `Cover`, as it's not a state, but more related to
        /// navigation, and navigation shouldn't be the task of ViewModel. So far navigation
        /// is done by View itself, but we can use some other entities for that process
        enum Cover: Identifiable {
            var id: String {
                String(describing: self)
            }
            
            case currentValue(UInt, Date)
            case showDate(Date)
        }

        @Published var cover: Cover?
        @Published var counter: UInt = 0 {
            didSet {
                lastChangeDate = Date()
            }
        }
        /// We should keep state as small as possible, so lastChangeDate isn't a part of state
        ///
        /// It always changes, when counter changes, so we'll always have views updated
        /// And to avoid any mistakes, we're setting this value observing `counter`
        private var lastChangeDate: Date = Date()

        func resetCounter() {
            counter = 0
        }

        func increaseCounter() {
            counter += 1
        }

        func showDetails() {
            self.cover = .currentValue(counter, lastChangeDate)
        }
        
        func showDate() {
            self.cover = .showDate(lastChangeDate)
        }

        func dismissCover() {
            self.cover = nil
        }
    }
}
