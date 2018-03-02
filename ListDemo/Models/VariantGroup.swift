//
//  VariantGroup.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/1/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

struct VariantGroup {
    var groupId: String
    var name: String
    var variations: [Variation]
    var isCollapsed: Bool = true
    
    enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
        case name
        case variations
    }
}

extension VariantGroup: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(groupId, forKey: .groupId)
        try container.encode(name, forKey: .name)
        try container.encode(variations, forKey: .variations)
    }
}

extension VariantGroup: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        groupId = try values.decode(String.self, forKey: .groupId)
        name = try values.decode(String.self, forKey: .name)
        variations = try values.decode([Variation].self, forKey: .variations)
    }
}

extension VariantGroup: VariantsViewModelItem {
    
    var groupTitle: String {
        return name
    }
    
    var rowCount: Int {
        return variations.count
    }
}

