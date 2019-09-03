//
//  RegistrationViewModel.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

protocol RegistrationViewModel {
    func registrate(username: String, login: String, email: String, password: String, onSuccess: @escaping () -> Void)
}

final class RegistrationViewModelImp: RegistrationViewModel {
    
    init(userPersistence: CurrentUserPersistence) {
        self.userPersistence = userPersistence
    }
    
    public func registrate(username: String,
                           login: String,
                           email: String,
                           password: String,
                           onSuccess: @escaping () -> Void)
    {
        userPersistence.register(login: login, password: password, name: username, email: email)
        { (result) in
            switch result {
            case .success:
                onSuccess()
            case .failure:
                // TODO: Viewving UI message
                ()
            }
        }
    }
    
    private var userPersistence: CurrentUserPersistence
}

