//
//  AuthorizationService.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

protocol AuthorizationService {
    func post(request: RequestAutorization, onComplete: @escaping (Result<ResponseAuthorized, ServiceError>) -> Void)
}
