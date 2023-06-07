//
//  ViewController.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func presentListModule(_ sender: Any) {
        let viewController = ListRouter.assembleModule(repository: ListMockRepository())
        navigationController?.pushViewController(viewController, animated: true)
    }
}

