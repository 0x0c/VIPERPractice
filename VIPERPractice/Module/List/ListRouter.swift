//
//  ListRouter.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import UIKit

protocol ListRouterInput: AnyObject {
    // MARK: View transitions
}

final class ListRouter {
    private unowned let viewController: ListViewController

    init(viewController: ListViewController) {
        self.viewController = viewController
    }

    static func assembleModule(repository: any ListRepositoryInterface) -> ListViewController {
        let view = ListViewController()
        let interactor = ListInteractor(repository: repository)
        let router = ListRouter(viewController: view)
        let presenter = ListPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

extension ListRouter: ListRouterInput {}
