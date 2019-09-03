//
//  PostService.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 15.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

protocol PostService {
    func post(request: RequestPost, onComplete: @escaping (Result<ResponsePost, ServiceError>) -> Void)
    func get(onComplete: @escaping (Result<[ResponsePost], ServiceError>) -> Void)
}
