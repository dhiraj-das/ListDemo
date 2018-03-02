//
//  APIClient.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/1/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

class APIClient {
    private var errorHandler: ((Error) -> Void) = { _ in }
    private var successHandler: ((Data) -> Void) = { _ in }
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func fetch(withRequest request: URLRequest) {
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _error = error {
                self.errorHandler(_error)
                return
            }
            guard let _data = data else {
                let error = NSError(domain: "network", code: 0, userInfo: nil)
                self.errorHandler(error)
                return
            }
            self.successHandler(_data)
        }
        task.resume()
    }
}

// MARK: - Handlers
extension APIClient {
    
    @discardableResult
    func onError(error: @escaping ((Error) -> Void)) -> Self {
        errorHandler = error
        return self
    }
    
    @discardableResult
    func onSuccess(success: @escaping (Data) -> Void) -> Self {
        successHandler = success
        return self
    }
}
