//
//  PostServiceImp.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 15.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

final class PostServiceImp: PostService, Service {

    var serviceSuffix: String {
        return "post"
    }
    
    func post(request: RequestPost, onComplete: @escaping (Result<ResponsePost, ServiceError>) -> Void) {
        guard let data = try? JSONEncoder().encode(request) else { return }
        let request = JSONRequest(url: url, httpMethods: .POST, body: data, token: nil)
        self.request(request: request, responseType: ResponsePost.self, onComplete: onComplete)
    }
    
    func get(onComplete: @escaping (Result<[ResponsePost], ServiceError>) -> Void) {
        let request = JSONRequest(url: url, httpMethods: .POST, body: nil, token: nil)
        self.request(request: request, responseType: [ResponsePost].self, onComplete: onComplete)
    }
}
