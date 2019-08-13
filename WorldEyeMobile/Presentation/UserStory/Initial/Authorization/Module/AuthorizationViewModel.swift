//
//  AuthorizationViewModel.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

final class AuthorizationViewModel {
    
    public func login(username: String, password: String) {
        let request = RequestAutorization(login: username, password: password)
        API.auth.post(request: request)
        { [weak self] (result) in
            switch result{
            case .success(let response):
                print("response: \(response)")
            case .failure(_):
                print("Boooo")
            }
        }
    }
}
