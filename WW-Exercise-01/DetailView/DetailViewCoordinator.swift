//
//  DetailViewCoordinator.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/27/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import UIKit

final class DetailViewCoordinator: UICoordinator {

    var navigationController: UINavigationController?
    weak var transitionDelegate: TransitionDelegate?

    private let foodItem: FoodListItem

    init(foodItem: FoodListItem) {
        self.foodItem = foodItem
    }

    lazy var primaryViewController: UIViewController = {
//        guard let apiManager = apiManager else { return UIViewController() }
//        let viewModel = FoodListViewModel(store: apiManager)
        let detailViewController = DetailViewController(foodItem: foodItem)
        return detailViewController
    }()

    func start() {
        navigationController?.pushViewController(primaryViewController, animated: true)
    }
}
