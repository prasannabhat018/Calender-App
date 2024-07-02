//
//  CalenderView.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation
import UIKit

final class CalenderView: UIView {
    let viewData: CalenderDate
    private var dateLabels: [Int: LabelButton] = [:]
    private weak var initialLabel: LabelButton?
    private weak var delegate: CalenderViewDelegate?
    
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = viewData.month.description
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(viewData.year)
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    init(viewData: CalenderDate, delegate: CalenderViewDelegate? = nil) {
        self.viewData = viewData
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
    }
    
    func setupView() {
        backgroundColor = .white
        let vertStack = UIStackView()
        vertStack.translatesAutoresizingMaskIntoConstraints = false
        vertStack.axis = .vertical
        vertStack.distribution = .fillEqually
        
        var dateNumber = 1
        
        // rows
        for _ in 0..<viewData.numberOfRowsRequired {
            let horStack = UIStackView()
            horStack.axis = .horizontal
            horStack.distribution = .fillEqually
            horStack.translatesAutoresizingMaskIntoConstraints = false
            
            // dates
            for _ in 0..<viewData.numberOfDaysInAWeek {
                let labelText = (dateNumber > viewData.numberOfDays) ? nil : dateNumber
                
                let label = LabelButton(labelText: labelText) { [weak self] dateNum, currentButton in
                    self?.didSelect(at: dateNum, current: currentButton)
                }
                // apply current selected date
                if dateNumber == viewData.day {
                    refreshBackground(label)
                }
                horStack.addArrangedSubview(label)
                NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: horStack.topAnchor),
                    label.bottomAnchor.constraint(equalTo: horStack.bottomAnchor)
                ])
                dateNumber += 1
                dateLabels[dateNumber] = label
            }
            
            vertStack.addArrangedSubview(horStack)
        }
        addSubview(monthLabel)
        addSubview(yearLabel)
        addSubview(vertStack)
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            yearLabel.topAnchor.constraint(equalTo: monthLabel.topAnchor),
            yearLabel.bottomAnchor.constraint(equalTo: monthLabel.bottomAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: monthLabel.trailingAnchor),
            yearLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            vertStack.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 16),
            vertStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            vertStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vertStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vertStack.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func refreshBackground(_ label: LabelButton) {
        initialLabel?.applyBackground = false
        label.applyBackground = true
        initialLabel = label
    }
    
    func didSelect(at atIndex: Int?, current: LabelButton) {
        guard let atIndex else { return }
        delegate?.didSelect(
            newDate: .init(
                day: atIndex,
                month: viewData.month.rawValue,
                year: viewData.year
            )
        )
        refreshBackground(current)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol CalenderViewDelegate: AnyObject {
    func didSelect(newDate: CalenderDate)
}
