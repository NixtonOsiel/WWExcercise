//
//  APIManager.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import Foundation

final class APIManager { }

protocol FoodListsStore {
    func readFoodLists(completion: @escaping (Result<[FoodListItem], APIError>) -> Void)
}

extension APIManager: FoodListsStore {

    func readFoodLists(completion: @escaping (Result<[FoodListItem], APIError>) -> Void) {
        guard let url = Endpoint.foodLists.url else { return }

        DispatchQueue.global(qos: .userInteractive).async {
            URLSession.shared.dataTask(with: url) { data, _, error in

                let decoder = JSONDecoder()

                guard
                    let entityData = data,
                    let decodedEntity = try? decoder.decode([FoodListItem].self, from: entityData), error == nil else {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }

                    return
                }

                DispatchQueue.main.async {
                    completion(.success(decodedEntity))
                }

            }.resume()
        }
    }
}
