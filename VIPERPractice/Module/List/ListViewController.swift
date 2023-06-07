//
//  ListViewController.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Combine
import Reusable
import UIKit

@MainActor
protocol ListViewInput: AnyObject {
    // MARK: Methods called from presenter
    func reloadData()
}

final class ListViewController: UITableViewController {
    // MARK: Stored instance properties

    var presenter: ListPresenterInput!
    private var cancellable = Set<AnyCancellable>()
    // MARK: Computed instance properties

    // MARK: IBOutlets

    // MARK: View Life-Cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: ListCell.self)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
        presenter.isLoadingPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else {
                    return
                }
                if isLoading {
                    self.refreshControl?.beginRefreshing()
                }
                else {
                    self.refreshControl?.endRefreshing()
                }
            }.store(in: &cancellable)
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.setContentOffset(
            CGPoint(x: 0, y: tableView.contentOffset.y - refreshControl!.frame.height),
            animated: true
        )
    }

    @objc
    private func refresh() {
        presenter.refreshData()
    }

    // MARK: Other private methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as ListCell
        let item = presenter.sections[indexPath.section].items[indexPath.row]
        cell.configure(for: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.sections[section].title
    }
}

extension ListViewController: ListViewInput {
    func reloadData() {
        tableView.reloadData()
    }
}
