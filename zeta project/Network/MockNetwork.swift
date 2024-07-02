//
//  MockNetwork.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation

final class MockNetworkRequest: NetworkHelpable {
    func processRequest<T>(get api: APIEndPoint,
                           completion: ((Result<T, CalenderError>) -> Void)) where T : Decodable {
        let customApi = api as! CustomCalenderAPI
        let events = [
            Event(
                name: "Event \(api.queryParams[0])",
                from: "12pm",
                to: "2pm",
                description: "Meeting"
            ),
            Event(
                name: "Event \(api.queryParams[1])",
                from: "4pm",
                to: "5pm",
                description: "Interview"
            )
        ]
        // Force unwrapping as it is a mock
        completion(.success(events as! T))
    }
}
