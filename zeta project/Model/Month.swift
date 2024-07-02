//
//  Month.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation

enum Month: Int, Equatable {
    case jan = 1
    case feb
    case mar
    case apr
    case may
    case jun
    case jul
    case aug
    case sep
    case oct
    case nov
    case dec
    
    var description: String {
        switch self {
        case .jan:
            "January"
        case .feb:
            "February"
        case .mar:
            "March"
        case .apr:
            "April"
        case .may:
            "May"
        case .jun:
            "June"
        case .jul:
            "July"
        case .aug:
            "August"
        case .sep:
            "September"
        case .oct:
            "October"
        case .nov:
            "November"
        case .dec:
            "December"
        }
    }
}
