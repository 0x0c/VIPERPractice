//
//  ListPresenter.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Combine
import Foundation

// MARK: - ListPresenterInput

@MainActor
protocol ListPresenterInput: AnyObject {
    var sections: [ListSectionViewModel] { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }

    func viewDidLoad()

    func refreshData()
    func didSelectRow(of viewModel: ListCellViewModel)
    func didSaveButtonPress()
}

// MARK: - ListPresenter

final class ListPresenter {
    // MARK: Lifecycle

    init(view: ListViewInput, interactor: ListInteractorInput, router: ListRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    // MARK: Internal

    weak var view: ListViewInput!
    var interactor: ListInteractorInput!
    var router: ListRouterInput!

    private(set) var sections: [ListSectionViewModel] = []

    // MARK: Private

    @Published private var isLoading = false
}

// MARK: ListPresenterInput

extension ListPresenter: ListPresenterInput {
    var isLoadingPublisher: Published<Bool>.Publisher {
        $isLoading
    }

    func viewDidLoad() {
        refreshData()
    }

    func didSelectRow(of viewModel: ListCellViewModel) {
        viewModel.checked.toggle()
        view.updateRow(for: viewModel)
    }

    func didSaveButtonPress() {
        let items = sections.flatMap { section in
            section.items.filter(\.checked).map(\.item)
        }
        if items.isEmpty {
            view.presentAlert(title: "Failed to save items", message: "No items selected.")
        }
        else {
            interactor.saveItems(items)
        }
    }

    func refreshData() {
        Task { [weak view] in
            isLoading = true
            do {
                let sections = try await interactor.loadSections()
                self.sections = sections.map {
                    ListSectionViewModel(section: $0)
                }
                view?.reloadData()
            }
            catch {
                // TODO: handle error
            }
            isLoading = false
        }
    }
}

// MARK: ListInteractorOutput

extension ListPresenter: ListInteractorOutput {
    func didSaveItems() {
        Task { @MainActor in
            view.presentAlert(title: "Saved", message: "Selected items saved.")
        }
    }
}
