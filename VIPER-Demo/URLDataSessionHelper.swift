//
//  URLDataSessionHelper.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 11/09/23.
//

import Foundation

struct NetworkResponse<T: Decodable> {
    let status: [String: Any]
    let message: T
}

struct URLDataSessionHelper {
    
    func hitAPI<T: Decodable>(
        endpoint: String,
        httpMethod: String,
        dataType: T.Type,
        completion: @escaping((T?, String?)->())
    ) {
        if let url = URL(string: endpoint) {
            
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(nil, error.localizedDescription)
                } else if let data = data {
                    let result = try? JSONDecoder().decode(BaseResponse<T>.self, from: data)
                    completion(result?.message, nil)
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }
            
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
    
}
