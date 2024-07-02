//
//  CalenderDateTests.swift
//  zeta projectTests
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation
import XCTest
@testable import zeta_project

class CalendarDateTests: XCTestCase {
    
    func testNumberOfRowsRequired() {
        let date = CalenderDate(day: 1, month: 7, year: 2024) // July 1, 2024
        XCTAssertEqual(date.numberOfRowsRequired, 5) // July 2024 has 5 weeks
    }
    
    func testInitWithValidDate() {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: currentDate)
        
        let calendarDate = CalenderDate(date: currentDate)
        
        XCTAssertEqual(calendarDate.day, components.day)
        XCTAssertEqual(calendarDate.month.rawValue, components.month)
        XCTAssertEqual(calendarDate.year, components.year)
    }
    
    func testNextMonthSameYear() {
        let date = CalenderDate(day: 31, month: 10, year: 2024) // October 31, 2024
        let nextMonthDate = date.getNextMonth(date.month)
        
        XCTAssertEqual(nextMonthDate.month, .nov)
        XCTAssertEqual(nextMonthDate.year, 2024)
    }
    
    func testNextMonthNextYear() {
        let date = CalenderDate(day: 31, month: 12, year: 2024) // December 31, 2024
        let nextMonthDate = date.getNextMonth(date.month)
        
        XCTAssertEqual(nextMonthDate.month, .jan)
        XCTAssertEqual(nextMonthDate.year, 2025)
    }
    
    func testNumberOfDaysInLeapYear() {
        let leapYearDate = CalenderDate(day: 1, month: 2, year: 2020) // February 1, 2020
        XCTAssertEqual(leapYearDate.numberOfDays, 29)
    }
    
    func testNumberOfDaysInNonLeapYear() {
        let nonLeapYearDate = CalenderDate(day: 1, month: 2, year: 2021) // February 1, 2021
        XCTAssertEqual(nonLeapYearDate.numberOfDays, 28)
    }
    
    func testIsLeapYear() {
        XCTAssertTrue(CalenderDate(day: 1, month: 1, year: 2000).isLeapYear)
        XCTAssertFalse(CalenderDate(day: 1, month: 1, year: 1900).isLeapYear)
        XCTAssertTrue(CalenderDate(day: 1, month: 1, year: 2004).isLeapYear)
        XCTAssertFalse(CalenderDate(day: 1, month: 1, year: 2001).isLeapYear)
    }
}
