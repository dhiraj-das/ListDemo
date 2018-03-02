//
//  RequestBuilder.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/1/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

class RequestBuilder {
    enum MethodType: String {
        case POST, GET, DELETE
    }
    
    private var methodType: MethodType = .GET
    private var urlString: String?
    private var httpBody: Data?
    private var contentType: String?
    
    func ofType(_ type: MethodType) -> Self {
        methodType = type
        return self
    }
    
    func set(urlString: String) -> Self {
        self.urlString = urlString
        return self
    }
    
    func set(httpBodyFromString: String) -> Self {
        self.httpBody = httpBodyFromString.data(using: .utf8)
        return self
    }
    
    func set(httpBody: Data) -> Self {
        self.httpBody = httpBody
        return self
    }
    
    func set(contentType: String) -> Self {
        self.contentType = contentType
        return self
    }
    
    func build() -> URLRequest {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        
        if let httpBody = httpBody {
            request.httpBody = httpBody
        }
        
        if let contentType = contentType {
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}
