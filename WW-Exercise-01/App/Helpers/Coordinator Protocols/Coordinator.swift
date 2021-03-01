//
//  Coordinator.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func start()
}

protocol UICoordinator: Coordinator {
    var primaryViewController: UIViewController { get }
    var navigationController: UINavigationController? { get set }
    var transitionDelegate: TransitionDelegate? { get set }
}

extension UICoordinator {
    func inject(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func inject(transitionDelegate: TransitionDelegate) {
        self.transitionDelegate = transitionDelegate
    }
}

protocol APICoordinator: Coordinator {
    var apiManager: APIManager? { get set }
}

protocol WorkFlowCoordinator: UICoordinator, APICoordinator { }

extension APICoordinator {
    func inject(apiManager: APIManager) {
        self.apiManager = apiManager
    }
}
