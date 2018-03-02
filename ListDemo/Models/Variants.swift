//
//  Variants.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/1/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

struct Variants {
    var variantGroups: [VariantGroup]
    var excludedPairs: [Int: [ExcludedCombination]] = [:]

    enum CodingKeys: String, CodingKey {
        case variants = "variants"
        case variantGroups = "variant_groups"
        case excludeList = "exclude_list"
    }
}

extension Variants: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(variantGroups, forKey: .variantGroups)
        try container.encode(excludedPairs, forKey: .excludeList)
    }
}

extension Variants: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let varientsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .variants)
        variantGroups = try varientsContainer.decode([VariantGroup].self, forKey: .variantGroups)
        
        let excludedListServiceModel = try varientsContainer.decode(ExcludedList.self, forKey: .excludeList)
        excludedPairs = excludedListServiceModel.excludedPairs
    }
}

