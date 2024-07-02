//
//  CalenderViewModelTests.swift
//  zeta projectTests
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation
import XCTest
@testable import zeta_project

class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel!
    var mockNetworkHelper: MockNetworkHelper!
    var mockDelegate: MockViewModelDelegate!
    
    override func setUpWithError() throws {
        mockNetworkHelper = MockNetworkHelper()
        mockDelegate = MockViewModelDelegate()
        viewModel = ViewModel(networkHelper: mockNetworkHelper, delegate: mockDelegate)
    }
    
    override func tearDownWithError() throws {
        mockNetworkHelper = nil
        mockDelegate = nil
        viewModel = nil
    }
    
    func testFetchEventsSuccess() {
        mockNetworkHelper.shouldSucceed = true
        
        viewModel.fetchEvents()
        
        XCTAssertTrue(mockDelegate.didCompleteFetchCalled)
        XCTAssertTrue(viewModel.events.isEmpty) // Since we're mocking with an empty array
    }
    
    func testFetchEventsFailure() {
        mockNetworkHelper.shouldSucceed = false
        
        viewModel.fetchEvents()
        
        XCTAssertTrue(mockDelegate.didCompleteFetchCalled)
        XCTAssertTrue(viewModel.events.isEmpty) // Events should remain empty on failure
    }
    
    func testFetchEventsForNewDate() {
        mockNetworkHelper.shouldSucceed = true
        let newDate = CalenderDate(day: 1, month: 1, year: 2025)
        
        viewModel.fetchEvents(for: newDate)
        
        XCTAssertEqual(viewModel.selectedDate.day, newDate.day)
        XCTAssertEqual(viewModel.selectedDate.month.rawValue, newDate.month.rawValue)
        XCTAssertEqual(viewModel.selectedDate.year, newDate.year)
        XCTAssertTrue(mockDelegate.didCompleteFetchCalled)
        XCTAssertTrue(viewModel.events.isEmpty) // Since we're mocking with an empty array
    }
}

// Mock ViewModelDelegate for testing purposes
class MockViewModelDelegate: ViewModelDelegate {
    var didCompleteFetchCalled = false
    
    func didCompleteFetch(isSuccess: Bool) {
        didCompleteFetchCalled = true
    }
}

// Mock NetworkHelper for testing purposes
class MockNetworkHelper: NetworkHelpable {
    var shouldSucceed = true // To control success/failure simulation
    
    func processRequest<T>(get api: APIEndPoint, completion: ((Result<T, CalenderError>) -> Void)) where T : Decodable {
        if shouldSucceed {
            // Simulate successful response with an empty array of events
            completion(.success([] as! T))
        } else {
            // Simulate failure response
            completion(.failure(.apiError))
        }
    }
}
