//
//  ListInteractor.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Foundation

// MARK: - ListInteractorInput

protocol ListInteractorInput: AnyObject {
    // MARK: Methods called from presenter

    func loadSections() async throws -> [ListSection]
    func saveItems(_ items: [ListItem])
}

// MARK: - ListInteractorOutput

protocol ListInteractorOutput: AnyObject {
    // MARK: Callback methods for presenter

    func didSaveItems()
}

// MARK: - ListInteractor

final class ListInteractor {
    // MARK: Lifecycle

    init(repository: any ListRepositoryInterface) {
        self.repository = repository
    }

    // MARK: Internal

    weak var presenter: ListInteractorOutput!

    // MARK: Private

    private let repository: any ListRepositoryInterface
}

// MARK: ListInteractorInput

extension ListInteractor: ListInteractorInput {
    func loadSections() async throws -> [ListSection] {
        return try await repository.loadSections()
    }

    func saveItems(_ items: [ListItem]) {
        presenter.didSaveItems()
    }
}
