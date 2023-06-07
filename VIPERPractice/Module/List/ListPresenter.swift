//
//  ListPresenter.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Combine
import Foundation

protocol ListPresenterInput: AnyObject {
    var sections: [ListSectionViewModel] { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }

    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View
    func refreshData()
}

final class ListPresenter {
    // MARK: VIPER properties

    weak var view: ListViewInput!
    var interactor: ListInteractorInput!
    var router: ListRouterInput!
    @Published private var isLoading = false

    // MARK: Stored instance properties
    private(set) var sections: [ListSectionViewModel] = []

    // MARK: Computed instance properties

    init(view: ListViewInput, interactor: ListInteractorInput, router: ListRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ListPresenter: ListPresenterInput {
    var isLoadingPublisher: Published<Bool>.Publisher {
        $isLoading
    }

    func viewDidLoad() {
        refreshData()
    }
    
    func refreshData() {
        Task { [weak view] in
            isLoading = true
            do {
                let sections = try await interactor.loadSection()
                self.sections = sections.map {
                    ListSectionViewModel(section: $0)
                }
                await view?.reloadData()
            } catch {
                // TODO: handle error
            }
            isLoading = false
        }
    }
}

extension ListPresenter: ListInteractorOutput {}
