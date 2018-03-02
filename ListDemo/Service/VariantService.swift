//
//  VariantService.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/1/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

class VariantService {
    
    private var apiClient: APIClient!
    
    init() {
        apiClient = APIClient()
    }
    
    func fetchData(completion: @escaping ((_ data: Variants?, _ error: Error?) -> Void)) {
        apiClient
            .onSuccess { (data) in
                let decoder = JSONDecoder()
                do {
                    let variants = try decoder.decode(Variants.self, from: data)
                    completion(variants, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
            .onError { (error) in
                completion(nil, error)
            }
            .fetch(withRequest: RequestFactory.variantsRequest())
    }
}
