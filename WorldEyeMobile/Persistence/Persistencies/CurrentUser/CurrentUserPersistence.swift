//
//  CurrentUserPersistence.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

protocol CurrentUserPersistence {
    var isAuthorized: Bool { get }
    
    func login(username: String, password: String, onComplete: @escaping (Result<User, PersistenceError>) -> Void)
    
    func register(login: String, password: String, name: String, email: String, onComplete: @escaping (Result<User, PersistenceError>) -> Void)
}
