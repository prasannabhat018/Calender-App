//
//  CalenderViewModel.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation

final class ViewModel {
    private let networkHelper: NetworkHelpable
    weak var delegate: ViewModelDelegate?
    
    var selectedDate: CalenderDate
    
    // to store all the fetched events
    // private var eventsMap: [(day: Int, month: Int, year: Int): [Event]] = [:]
    var events: [Event] = []
    
    
    init(networkHelper: NetworkHelpable, delegate: ViewModelDelegate? = nil) {
        self.networkHelper = networkHelper
        self.delegate = delegate
        // default current selected date at the begining
        self.selectedDate = .init(date: Date())
    }
    
    // date day and year passed in parameters
    func fetchEvents() {
        let api = CustomCalenderAPI.daily(day: selectedDate.day,
                                          month: selectedDate.month.rawValue,
                                          year: selectedDate.year)
        
        networkHelper.processRequest(get: api) { [weak self] (result: Result<[Event], CalenderError>) in
            guard let self, case .success(let events) = result else {
                self?.delegate?.didCompleteFetch(isSuccess: false)
                return
            }
            self.events = events
            delegate?.didCompleteFetch(isSuccess: true)
        }
    }
    
    func fetchEvents(for newDate: CalenderDate) {
        selectedDate = newDate
        fetchEvents()
    }
}

protocol ViewModelDelegate: AnyObject {
    func didCompleteFetch(isSuccess: Bool)
}
