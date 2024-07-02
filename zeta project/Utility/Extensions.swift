//
//  Extensions.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation

// MARK: Utility
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
