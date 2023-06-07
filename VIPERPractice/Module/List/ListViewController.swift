//
//  ListViewController.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Combine
import Reusable
import UIKit

// MARK: - ListViewInput

@MainActor
protocol ListViewInput: AnyObject {
    // MARK: Methods called from presenter

    func reloadData()
    func updateRow(for viewModel: ListCellViewModel)
    func presentAlert(title: String, message: String)
}

// MARK: - ListViewController

final class ListViewController: UITableViewController {
    // MARK: Internal

    var presenter: ListPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        tableView.register(cellType: ListCell.self)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                title: "Save",
                style: .done,
                target: self,
                action: #selector(didSaveButtonPress)
            )
        ]
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
    func didSaveButtonPress() {
        presenter.didSaveButtonPress()
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
        let viewModel = presenter.sections[indexPath.section].items[indexPath.row]
        viewModel.indexPath = indexPath
        cell.configure(for: viewModel)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = presenter.sections[indexPath.section].items[indexPath.row]
        presenter.didSelectRow(of: viewModel)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.sections[section].title
    }

    // MARK: Private

    private var cancellable = Set<AnyCancellable>()

    @objc
    private func refresh() {
        presenter.refreshData()
    }
}

// MARK: ListViewInput

extension ListViewController: ListViewInput {
    func reloadData() {
        tableView.reloadData()
    }

    func updateRow(for viewModel: ListCellViewModel) {
        guard let indexPath = viewModel.indexPath else {
            return
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }

    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Done", style: .default))
        present(alert, animated: true)
    }
}
