//
//  ProfileAssembly.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 03.09.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Swinject

final class ProfileAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileViewModel.self) { (resolver) in
            let currentUserPersistence = resolver.resolve(CurrentUserPersistence.self)!
            return ProfileViewModelImp(currentUserPersistence: currentUserPersistence)
        }
    }
}
