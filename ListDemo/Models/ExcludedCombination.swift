//
//  ExcludedCombination.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/1/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

struct ExcludedCombination {
    var groupId: String = ""
    var variationId: String = ""
    
    enum CodingKeys: String, CodingKey {
        case variationId = "variation_id"
        case groupId = "group_id"
        case excludeList = "exclude_list"
    }
}

extension ExcludedCombination: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(groupId, forKey: .groupId)
        try container.encode(variationId, forKey: .variationId)
    }
}

extension ExcludedCombination: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        groupId = try container.decode(String.self, forKey: .groupId)
        variationId = try container.decode(String.self, forKey: .variationId)
    }
}

extension ExcludedCombination: Hashable {
    var hashValue: Int {
        return groupId.hashValue
    }
    
    static func ==(lhs: ExcludedCombination, rhs: ExcludedCombination) -> Bool {
        return lhs.groupId == rhs.groupId && lhs.variationId == rhs.variationId
    }
}



