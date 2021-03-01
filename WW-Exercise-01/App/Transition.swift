//
//  Transition.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import Combine

protocol TransitionDelegate: class {
    func process(transition: Transition)
}

enum Transition {
    case showFoodList
    case showDetailView(FoodListItem)
}
