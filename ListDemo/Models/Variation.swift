//
//  Variation.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/1/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

struct Variation {
    var name: String
    var price: Int
    var isDefault: Bool
    var id: String
    var inStock: Bool
    var isVeg: Bool
    
    var isSelected: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case isDefault = "default"
        case id
        case inStock
        case isVeg
    }
}

extension Variation: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(isDefault, forKey: .isDefault)
        try container.encode(id, forKey: .id)
        try container.encode(inStock, forKey: .inStock)
        try container.encode(isVeg, forKey: .isVeg)
    }
}

extension Variation: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        price = try values.decode(Int.self, forKey: .price)
        id = try values.decode(String.self, forKey: .id)
        
        let isDefaultNumber = try values.decode(Int.self, forKey: .isDefault)
        let inStockNumber = try values.decode(Int.self, forKey: .inStock)
        let isVegNumber = try values.decodeIfPresent(Int.self, forKey: .isVeg)
        
        isDefault = isDefaultNumber == 1
        inStock = inStockNumber == 1
        isVeg = isVegNumber == 1
        
        isSelected = isDefault
    }
}


