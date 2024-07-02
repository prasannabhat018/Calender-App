//
//  CalenderAPI.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation

enum CustomCalenderAPI: APIEndPoint {
    case daily(day: Int?, month: Int?, year: Int?)
    // monthly
    // weekly
    
    var scheme: HTTPScheme { .https }
    
    var method: HTTPMethod { .get }
    
    var host: String { "apple.calender.com" }
    
    var path: String { "daily/events" }
    
    var queryParams: [URLQueryItem] {
        switch self {
        case .daily(let day, let month, let year):
            [
                URLQueryItem(name: "day", value: String(day ?? 0)),
                URLQueryItem(name: "month", value: String(month ?? 0)),
                URLQueryItem(name: "year", value: String(year ?? 0))
            ]
        }
    }
}
