//
//  Endpoint.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import Foundation

enum Endpoint {

    case foodLists
    case image(String)

    var url: URL! {

        guard let baseURL = URL(string: "http://www.weightwatchers.com/") else { return nil }

        switch self {
        case .foodLists: return baseURL.appendingPathComponent("assets/cmx/us/messages/collections.json")
        case .image(let path): return baseURL.appendingPathComponent(path)

        }
    }
}
