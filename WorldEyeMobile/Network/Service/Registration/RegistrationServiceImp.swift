//
//  RegistrationServiceImp.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

final class RegistrationServiceImp: RegistrationService, Service {
    
    var serviceSuffix: String {
        return "registration"
    }
    
    func post(request: RequestRegistration,
              onComplete: @escaping (Result<ResponseAuthorized, ServiceError>) -> Void)
    {
        guard let data = try? JSONEncoder().encode(request) else { return }
        let request = JSONRequest(url: url, httpMethods: .POST, body: data, token: nil)
        self.request(request: request, responseType: ResponseAuthorized.self, onComplete: onComplete)
    }
}
