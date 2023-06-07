//
//  ListInteractor.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Foundation

protocol ListInteractorInput: AnyObject {
    // MARK: Methods called from presenter

    func loadSections() async throws -> [ListSection]
    func saveItems(_ items: [ListItem])
}

protocol ListInteractorOutput: AnyObject {
    // MARK: Callback methods for presenter
    func didSave()
}

final class ListInteractor {
    // MARK: VIPER property
    weak var presenter: ListInteractorOutput!
    private let repository: any ListRepositoryInterface

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    // MARK: Initializer
    
    init(repository: any ListRepositoryInterface) {
        self.repository = repository
    }

    // MARK: Other private methods
}

extension ListInteractor: ListInteractorInput {
    func loadSections() async throws -> [ListSection] {
        return try await repository.loadSections()
    }

    func saveItems(_ items: [ListItem]) {
        presenter.didSave()
    }
}
