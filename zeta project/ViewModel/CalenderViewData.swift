//
//  CalenderViewData.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation

struct CalenderDate {
    var day: Int
    private(set) var numberOfDaysInAWeek: Int = 7
    var month: Month
    var year: Int
    
    var numberOfRowsRequired: Int {
        return Int(ceil(Double(numberOfDays)/Double(numberOfDaysInAWeek)))
    }
    
    init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = Month(rawValue: month) ?? .jan // TODO: add validation
        self.year = year
    }
    
    init(date: Date) {
        let currentDateComponents = Date().get(.day, .month, .year)
        // TODO: add validation
        day = currentDateComponents.day ?? 0
        month = Month(rawValue: currentDateComponents.month ?? 0) ?? .jan
        year = currentDateComponents.year ?? 0
    }
    
    // possible scenarios
    // Next Month and same year - Ex - oct'24 will become nov'24
    // Next Month and next year - Ex - dec'24 will become jan'25
    func getNextMonth(_ month: Month) -> (month: Month, year: Int) {
        if let nextMonth = Month(rawValue: month.rawValue + 1) {
            return (nextMonth, year)
        }
        return (.jan, year + 1)
    }
    
    var numberOfDays: Int {
        switch month {
        case .jan, .mar, .may, .jul, .aug, .oct, .dec:
            return 31
        case .feb:
            if isLeapYear {
                return 29
            } else {
                return 28
            }
        default:
            return 30
        }
    }
    
    var isLeapYear: Bool {
        if year % 400 == 0 { return true }
        if year % 100 == 0 { return false }
        if year % 4 == 0 { return true }
        return false
    }
}
