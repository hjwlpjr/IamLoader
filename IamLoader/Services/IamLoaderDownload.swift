//
//  IamLoaderDownload.swift
//  IamLoader
//
//  Created by Andy on 11/08/19.
//  Copyright © 2019 Andy Wijaya. All rights reserved.
//

import Foundation

public class IamLoaderDownload {
    
    public init() {
    }
    
    public func downloadData(apiUrl: String, completion: @escaping(Result<Data, RequestError>) -> ()) {
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }).resume()
    }
}
