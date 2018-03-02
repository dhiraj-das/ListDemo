//
//  ExcludedList.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/2/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

struct ExcludedList {
    var excludedCombinations: [ExcludedCombination] = []
    var excludedPairs: [Int: [ExcludedCombination]] = [:]
}

extension ExcludedList: Decodable {
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        guard let count = container.count else { return }
        while container.currentIndex < count {
            excludedCombinations = []
            var nestedContainer = try container.nestedUnkeyedContainer()
            guard let count = nestedContainer.count else { return }
            while nestedContainer.currentIndex < count {
                let combination = try nestedContainer.decode(ExcludedCombination.self)
                excludedCombinations.append(combination)
            }
            excludedPairs[container.currentIndex] = excludedCombinations
        }
    }
}
