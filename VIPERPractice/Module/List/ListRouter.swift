//
//  ListRouter.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import UIKit

// MARK: - ListRouterInput

protocol ListRouterInput: AnyObject {
    // MARK: View transitions
}

// MARK: - ListRouter

final class ListRouter {
    // MARK: Lifecycle

    init(viewController: ListViewController) {
        self.viewController = viewController
    }

    // MARK: Internal

    static func assembleModule(repository: any ListRepositoryInterface) -> ListViewController {
        let view = ListViewController()
        let interactor = ListInteractor(repository: repository)
        let router = ListRouter(viewController: view)
        let presenter = ListPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }

    // MARK: Private

    private unowned let viewController: ListViewController
}

// MARK: ListRouterInput

extension ListRouter: ListRouterInput {}
