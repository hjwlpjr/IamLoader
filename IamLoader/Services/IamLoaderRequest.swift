//
//  IamLoaderRequest.swift
//  IamLoader
//
//  Created by Andy on 11/08/19.
//  Copyright © 2019 Andy Wijaya. All rights reserved.
//

import Foundation

public class IamLoaderRequest {
    
    public init() {
    }
    
    func loadJSON<T: Decodable>(apiUrl: String, completion: @escaping (Bool, T) -> ()) {
        
        let apiUrl = apiUrl
        
        guard let url = URL(string: apiUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            
            if let error = error {
                print("fail to fetch data", error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("error")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedModel = try JSONDecoder().decode(T.self, from: data)
                if httpResponse.statusCode >= 400 {
                    completion(false, decodedModel)
                } else {
                    completion(true, decodedModel)
                }
            } catch {
                print(error)
            }
            
        }).resume()
    }
}
