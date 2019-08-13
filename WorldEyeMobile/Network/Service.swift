//
//  Service.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

enum HTTPMethods: String {
    case POST
    case GET
    case PATCH
    case DELETE
}

enum HTMLStatusCode: Int {
    case Ok = 200
    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case NotAllowed = 405
    case Internal = 500
    case NotImplemented = 501
}

enum JsonParseError: String, Error {
    case invalidDate
    case noDataSection
}

enum ServiceError: Error {
    case decoding
    case server
    case htmlCode
}

protocol Request {
    var url: URL {get set}
    var httpMethods: HTTPMethods {get set}
    var body: Data? {get set}
    var token: String? {get set}
    
    func make() -> URLRequest
}

struct JSONRequest: Request {
    var url: URL
    var httpMethods: HTTPMethods
    var body: Data?
    var token: String?
    
    func make() -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethods.rawValue
        request.httpBody = body
        
        // Headers
        if let token = token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.addValue("application/json; version=1.0", forHTTPHeaderField: "Accept")
        
        return request
    }
}

protocol Service: Network {
    
    var serviceSuffix: String {get}
    
    func request<Response: Decodable>(request: Request,
                                      responseType: Response.Type,
                                      onComplete: @escaping (Result<Response, ServiceError>) -> Void)
}

extension Service {
    var basePath: String {
        return "http://127.0.0.1:8881"
    }
    
    var serviceSuffix: String {
        return ""
    }
    
    var url: URL {
        if let url = URL(string: "\(self.basePath)/\(self.serviceSuffix)") {
            return url
        } else {
            #if DEBUG
                fatalError("Wrong serviceSuffix: \(self.serviceSuffix)")
            #else
                return URL(string: self.basePath)!
            #endif
        }
    }
    
    func request<Response: Decodable>(request: Request, responseType: Response.Type, onComplete: @escaping (Result<Response, ServiceError>) -> Void) {
        if let body = request.body {
            print("--------------------------------------------------------------------------------")
            print("REQEST BODY:")
            print(String(data: body, encoding: String.Encoding.utf8) ?? "Not convertable to UTF8")
            print("--------------------------------------------------------------------------------")
        }
        
        self.makeRequest( request: request.make(),
                          success: { (data: Data, _: URLRequest, response: HTTPURLResponse) in
                            if let statusCode = HTMLStatusCode(rawValue: response.statusCode) {
                                switch statusCode {
                                case .Ok:
                                    do {
                                        let rawDecoded = try JSONSerialization.jsonObject(with: data, options: [])
                                        print("--------------------------------------------------------------------------------")
                                        print("SUCCESS: \(statusCode)")
                                        print("\(response.url!)")
                                        print("--------------------------------------------------------------------------------")
                                        print(rawDecoded)
                                        print("--------------------------------------------------------------------------------")
                                        print("")
                                        
                                        let decodedResponse: Response = try self.decodeResponseGeneric(data: data)
                                        onComplete(.success(decodedResponse))
                                    } catch {
                                        onComplete(.failure(ServiceError.decoding))
                                    }
                                case .Unauthorized:
                                    // Try to retrieve a new token, then call same method again
                                    print("ERROR un-auth: \(data)")
                                case .BadRequest, .Forbidden, .NotFound, .NotAllowed, .Internal, .NotImplemented:
                                    do {
                                        let rawDecoded = try JSONSerialization.jsonObject(with: data, options: [])
                                        print("--------------------------------------------------------------------------------")
                                        print("ERROR: \(statusCode)")
                                        print("\(response.url!)")
                                        print("--------------------------------------------------------------------------------")
                                        print(rawDecoded)
                                        print("--------------------------------------------------------------------------------")
                                        print("")
                                    } catch {
                                        print(error.localizedDescription)
                                        onComplete(.failure(ServiceError.decoding))
                                    }
                                    
                                    onComplete(.failure(ServiceError.htmlCode))
                                }
                            } else {
                                onComplete(.failure(ServiceError.htmlCode))
                            }
        },
                          failure: { (_: Error, _: URLRequest) in
                            onComplete(.failure(ServiceError.server))
        })
    }
    
    // MARK: Decoder
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder: Decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateRepr = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            if let date = formatter.date(from: dateRepr) {
                return date
            } else {
                print("About to throw date error: \(dateRepr)")
                throw JsonParseError.invalidDate
            }
        })
        return decoder
    }
    
    func decodeResponseGeneric<T: Decodable>(data: Data) throws -> T {
        let decoded = try self.decoder.decode(Response<T>.self, from: data)
        return decoded.data
    }
}
