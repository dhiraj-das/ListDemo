//
//  RequestFactory.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/1/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

class RequestFactory {
    static func variantsRequest() -> URLRequest {
        let urlString = "https://api.myjson.com/bins/3b0u2"
        
        let request = RequestBuilder()
            .ofType(.GET)
            .set(urlString: urlString)
            .build()
        
        return request
    }
}
