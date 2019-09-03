//
//  UserStorageImp.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation
import RxSwift

final class UserStorageImp: UserStorage {
    
    // MARK: UserStorage
    
    public var current: Observable<User> {
        return rxCurrentUserDAO
            .changes(forObjectWithId: C.Database.singleDBId,
                     withTranslator: CurrentUserTranslator())
            .map({ $0 as! User })
    }
    
    public func persisteAsCurent(user: User) {
        let currentUser = CurrentUser(id: C.Database.singleDBId, user: user)
        currentUserDAO.persist(withEntity: currentUser)
    }
    
    public func getCurent() -> User? {
        if let currentUser = currentUserDAO.read(byID: C.Database.singleDBId) as? CurrentUser {
            return currentUser.user
        }
        return nil
    }
    
    public func logout() {
        userDAO.erase()
        currentUserDAO.erase()
    }
    
    // MARK: Initializer
    
    init() {
        rxCurrentUserDAO = RxDAO<CurrentUserEntry>(disposeBag: disposeBag)
    }
    
    // MARK: Private
    
    private var userDAO = DAO<UserEntry>(translator: UserTranslator())
    
    private var currentUserDAO = DAO<CurrentUserEntry>(translator: CurrentUserTranslator())
    
    private var rxCurrentUserDAO: RxDAO<CurrentUserEntry>
    
    private let disposeBag = DisposeBag()
}
