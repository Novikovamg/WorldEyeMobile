//
//  UserStorage.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

protocol UserStorage {
    func persisteAsCurent(user: User)
    func getCurent() -> User?
}
