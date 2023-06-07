//
//  ListInteractor.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Foundation

protocol ListInteractorInput: AnyObject {
    // MARK: Methods called from presenter

    func loadSection() async throws -> [ListSection]
}

protocol ListInteractorOutput: AnyObject {
    // MARK: Methods called from repository
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
    func loadSection() async throws -> [ListSection] {
        return try await repository.loadSection()
    }
}
