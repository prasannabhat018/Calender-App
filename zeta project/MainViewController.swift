//
//  MainViewController.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    let tableViewCellName = "cell"
    let viewModel: ViewModel
    
    lazy var calenderView: CalenderView = {
        let view = CalenderView(viewData: viewModel.selectedDate, delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellName)
        return tableView
    }()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        self.viewModel.fetchEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.addSubview(calenderView)
        view.addSubview(tableView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            calenderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calenderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calenderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: calenderView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: Refresh Logic
extension MainViewController: ViewModelDelegate {
    func didCompleteFetch(isSuccess: Bool) {
        if isSuccess {
            tableView.reloadData()
        }
        // TODO: Error Case Handling
    }
}


// MARK: Table View Related
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellName, for: indexPath)
        guard indexPath.row < viewModel.events.count else {
            cell.textLabel?.text = "Invalid"
            return cell
        }
        cell.textLabel?.text = viewModel.events[indexPath.row].name
        cell.detailTextLabel?.text = viewModel.events[indexPath.row].descriptionCombination
        return cell
    }
    
    // MARK: Header Data
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let headerLabel = UILabel(frame: CGRect(x: 15, y: 10, width: tableView.frame.width - 30, height: 30))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel.textColor = UIColor.black
        headerLabel.text = "Events For The Day"

        headerView.addSubview(headerLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50 // Adjust this value according to your header's desired height
    }

}

// MARK: Calender View Related
extension MainViewController: CalenderViewDelegate {
    func didSelect(newDate: CalenderDate) {
        viewModel.fetchEvents(for: newDate)
    }
}
