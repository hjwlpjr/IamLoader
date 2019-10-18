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
    
    public func fetchData<T: Decodable>(apiUrl: String, type: DataType, completion: @escaping (Result<T, RequestError>) -> ()) {
        
        let apiUrl = apiUrl
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            
            if error != nil {
                completion(.failure(.errFetchData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.errHttpResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                switch type {
                    case .json:
                        let decodedModel = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedModel))
                }
            } catch {
                completion(.failure(.failDecode))
            }
            
        }).resume()
    }
    
    public func fetchDataWithParams<T: Decodable, P: Decodable>(apiUrl: String, parameter: P, type: DataType, completion: @escaping (Result<T, RequestError>) -> ()) {
        
        let paramMirror = Mirror(reflecting: parameter)
        let params = paramMirror.children.map { (child) -> String in
            return "\(child.label ?? "")=\(child.value)"
        }
        
        let apiUrl = "\(apiUrl)?\(params.joined(separator: "&"))"
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            
            if error != nil {
                completion(.failure(.errFetchData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.errHttpResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                switch type {
                case .json:
                    let decodedModel = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedModel))
                }
            } catch {
                completion(.failure(.failDecode))
            }
            
        }).resume()
    }
    
    func postData<T: Codable, U: Decodable>(apiUrl: String, body: T, completion: @escaping (Result<U, RequestError>) -> ()) {
        
        let apiUrl = apiUrl
        
        do {
            let payload = try JSONEncoder().encode(body)
            guard let url = URL(string: apiUrl) else {
                completion(.failure(.badUrl))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = payload
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                
                if let error = error {
                    completion(.failure(.errFetchData))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.errHttpResponse))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decodedModel = try JSONDecoder().decode(U.self, from: data)
                    completion(.success(decodedModel))
                } catch {
                    completion(.failure(.failDecode))
                }
                
            }).resume()
        } catch {
            completion(.failure(.badUrl))
        }
    }
}
