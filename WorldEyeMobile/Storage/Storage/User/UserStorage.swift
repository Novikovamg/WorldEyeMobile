//
//  UserStorage.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import RxSwift

protocol UserStorage {
    var current: Observable<User> { get }
    
    func persisteAsCurent(user: User)
    func getCurent() -> User?
    func logout()
}
