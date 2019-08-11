//
//  Error.swift
//  IamLoader
//
//  Created by Andy on 11/08/19.
//  Copyright © 2019 Andy Wijaya. All rights reserved.
//

import Foundation

public enum RequestError: Error {
    case badUrl
    case errFetchData
    case errHttpResponse
    case noData
    case serverError
    case failDecode
}

extension RequestError: LocalizedError {
    public var errorMessage: String? {
        switch self {
        case .badUrl:
            return "url provided is not valid"
        case .errFetchData:
            return "Fail to fetch data"
        case .errHttpResponse:
            return "Fail to get response from server"
        case .noData:
            return "No data from server"
        case .serverError:
            return "Internal server error"
        case .failDecode:
            return "Fail to decode model"
        }
    }
}
