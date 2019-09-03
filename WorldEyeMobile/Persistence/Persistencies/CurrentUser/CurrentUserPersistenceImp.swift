//
//  CurrentUserPersistenceImp.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

final class CurrentUserPersistenceImp: CurrentUserPersistence {
    
    // MARK: Initializer
    
    init(userStorage: UserStorage) {
        self.userStorage = userStorage
    }
    
    // MARK: CurrentUserPersistence
    
    var isAuthorized: Bool {
        if let user = userStorage.getCurent() {
            API.settings.requestToken = user.login
            return true
        }
        return false
    }
    
    public func login(username: String,
                      password: String,
                      onComplete: @escaping (Result<User, PersistenceError>) -> Void)
    {
        let request = RequestAutorization(login: username, password: password)
        API.auth.post(request: request)
        { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                let user = ResponseUserTranslator.toEntity(from: response)
                API.settings.requestToken = user.login
                self.userStorage.persisteAsCurent(user: user)
                DispatchQueue.main.async {
                    onComplete(.success(user))
                }
            case .failure(_):
                DispatchQueue.main.async {
                    onComplete(.failure(.serverError))
                }
            }
        }
    }
    
    public func register(login: String,
                         password: String,
                         name: String,
                         email: String,
                         onComplete: @escaping (Result<User, PersistenceError>) -> Void)
    {
        let request = RequestRegistration(login: login,
                                          email: email,
                                          name: name,
                                          password: password)
        API.registration.post(request: request)
        { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                let user = ResponseUserTranslator.toEntity(from: response)
                API.settings.requestToken = user.login
                self.userStorage.persisteAsCurent(user: user)
                DispatchQueue.main.async {
                    onComplete(.success(user))
                }
            case .failure(_):
                DispatchQueue.main.async {
                    onComplete(.failure(.serverError))
                }
            }
        }
    }
    
    public func logout() {
        userStorage.logout()
    }
    
    // MARK: Private
    
    private var userStorage: UserStorage
}
