//
//  Network.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case Unknown
    case InvalidResponseObject
    case InvalidResponseBody
    case NoData
    
    var description: String {
        switch self {
        case .Unknown: return "An unknown error occurred"
        case .InvalidResponseObject: return "Invalid response object"
        case .InvalidResponseBody: return "Received an invalid response body"
        case .NoData: return "No data received"
        }
    }
}

protocol Network {
    @discardableResult
    func makeRequest(request: URLRequest,
                     success: @escaping (_ data: Data, _ request: URLRequest, _ response: HTTPURLResponse) -> Void,
                     failure: @escaping (_ error: Error, _ request: URLRequest) -> Void
        ) -> URLSessionTask
}

extension Network {
    @discardableResult
    func makeRequest(request: URLRequest,
                     success: @escaping (_ data: Data, _ request: URLRequest, _ response: HTTPURLResponse) -> Void,
                     failure: @escaping (_ error: Error, _ request: URLRequest) -> Void
        ) -> URLSessionTask
    {
        let task = URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                guard error == nil else {
                    // Error is present, return
                    return failure(error ?? NetworkError.Unknown, request)
                }
                
                if let data = data {
                    // Data is present
                    if (try? JSONSerialization.jsonObject(with: data, options: [])) != nil {
                        if let response = response as? HTTPURLResponse {
                            return success(data, request, response)
                        } else {
                            return failure(NetworkError.InvalidResponseObject, request)
                        }
                    } else {
                        return failure(NetworkError.InvalidResponseBody, request)
                    }
                } else {
                    return failure(NetworkError.NoData, request)
                }
        })
        task.resume()
        return task
    }
}
