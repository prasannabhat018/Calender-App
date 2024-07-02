//
//  Event.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation

struct Event: Decodable {
    var name: String
    var from: String
    var to: String
    var description: String
    
    var descriptionCombination: String {
        return (from + "-" + to + "\n" + description)
    }
}
