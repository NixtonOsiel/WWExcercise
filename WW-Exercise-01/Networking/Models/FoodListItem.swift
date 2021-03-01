//
//  FoodList.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import Foundation

struct FoodListItem: Decodable {

    let uuid: String
    let image: String
    let title: String
    let filter: String

    enum CodingKeys: String, CodingKey {
        case image
        case title
        case filter
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decode(String.self, forKey: .image)
        title = try values.decode(String.self, forKey: .title)
        filter = try values.decode(String.self, forKey: .filter)
        uuid = UUID().uuidString
    }
}

extension FoodListItem: Hashable {

    func hash(into hasher: inout Hasher) {
      hasher.combine(uuid)
    }

    static func == (lhs: FoodListItem, rhs: FoodListItem) -> Bool {
      lhs.uuid == rhs.uuid
    }
}
