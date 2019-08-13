//
//  PersistenceAssembly.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

import Swinject

final class PersistenceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CurrentUserPersistence.self) { (resolver) in
            let userStorage = resolver.resolve(UserStorage.self)!
            return CurrentUserPersistenceImp(userStorage: userStorage)
        }.inObjectScope(.container)
    }
}
