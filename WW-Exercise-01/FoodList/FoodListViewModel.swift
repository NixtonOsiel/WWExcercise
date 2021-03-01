//
//  FoodListViewModel.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import Foundation
import Combine

final class FoodListViewModel {

    let foodEntitySubject = PassthroughSubject<[FoodListItem], Error>()

    private let store: FoodListsStore
    private var foodList: [FoodListItem] = []

    init(store: FoodListsStore) {
        self.store = store
    }

    func loadData() {
        store.readFoodLists { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let foodList):
                self.foodList = foodList
                self.foodEntitySubject.send(foodList)

            case .failure(let error):
                self.foodEntitySubject.send(completion: .failure(error))
            }
        }
    }

    func searchFoodList(for query: String?) {

        if let query = query, !query.isEmpty {
            let lowerCaseQuery = query.lowercased()
            let filteredFoodList = foodList.filter {
                $0.title.lowercased().contains(lowerCaseQuery)
            }

            foodEntitySubject.send(filteredFoodList)
        } else {
            foodEntitySubject.send(foodList)
        }
    }
}
