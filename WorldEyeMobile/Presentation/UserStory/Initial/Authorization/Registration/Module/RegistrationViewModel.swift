//
//  RegistrationViewModel.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

final class RegistrationViewModel {
    
    init(userPersistence: CurrentUserPersistence) {
        self.userPersistence = userPersistence
    }
    
    public func registrate(username: String,
                           login: String,
                           email: String,
                           password: String)
    {
        userPersistence.register(login: login, password: password, name: username, email: email)
        { (result) in
            
        }
    }
    
    private var userPersistence: CurrentUserPersistence
    
}
