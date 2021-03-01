//
//  FoodListCoordinator.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import UIKit

final class FoodListCoordinator: WorkFlowCoordinator {

    var navigationController: UINavigationController?
    weak var transitionDelegate: TransitionDelegate?
    var apiManager: APIManager?

    lazy var primaryViewController: UIViewController = {
        guard let apiManager = apiManager else { return UIViewController() }
        let viewModel = FoodListViewModel(store: apiManager)
        let foodListViewController = FoodListViewController(viewModel: viewModel)
        foodListViewController.didSelectFoodItem = { [weak self] foodItem in
//            self?.transitionDelegate?.process(transition: .showDetailView(foodItem))
        }
        return foodListViewController
    }()

    func start() {
        navigationController?.pushViewController(primaryViewController, animated: false)
    }
}
