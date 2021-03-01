//
//  String+Formatter.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/17/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import Foundation

extension String {
    func stringByRemovingSpecifiedChars(_ charsToRemove: String) -> String {

        var newSelf = self

        charsToRemove.forEach {
            let tempString = newSelf.replacingOccurrences(of: String($0), with: "")
            newSelf = tempString
        }

        return newSelf
    }
}
