//
//  UserStorageImp.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

enum CurrentUserStorageConstants {
    static let id = "AlwaysOneObject"
}

final class UserStorageImp: UserStorage {
    
    // MARK: DAO
    
    private var userDAO = DAO<UserEntry>(translator: UserTranslator())
    private var currentUserDAO = DAO<CurrentUserEntry>(translator: CurrentUserTranslator())
    
    // MARK: UserStorage
    
    func persisteAsCurent(user: User) {
        let currentUser = CurrentUser(id: CurrentUserStorageConstants.id, user: user)
        currentUserDAO.persist(withEntity: currentUser)
    }
    
    func getCurent() -> User? {
        if let currentUser = currentUserDAO.read(byID: CurrentUserStorageConstants.id) as? CurrentUser {
            return currentUser.user
        }
        return nil
    }
}
