//
//  AppCoordinator.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {

    let rootViewController = UINavigationController()

    private let apiManager = APIManager()

    func start() {
        process(transition: .showFoodList)
    }

    let coordinator = FoodListCoordinator()
}

extension AppCoordinator: TransitionDelegate {

    func process(transition: Transition) {
        print("Processing route: \(transition)")

        switch transition {
            case .showFoodList:

                coordinator.inject(apiManager: apiManager)
                coordinator.inject(transitionDelegate: self)
                coordinator.inject(navigationController: rootViewController)
                coordinator.start()

            case .showDetailView(let foodItem):
                let coordinator = DetailViewCoordinator(foodItem: foodItem)
                coordinator.inject(transitionDelegate: self)
                coordinator.inject(navigationController: rootViewController)
                coordinator.start()
        }
    }
}
