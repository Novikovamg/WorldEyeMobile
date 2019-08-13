//
//  StorageAssembly.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Swinject

final class StorageAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UserStorage.self) { (_) in
            return UserStorageImp()
        }.inObjectScope(.container)
    }
}
