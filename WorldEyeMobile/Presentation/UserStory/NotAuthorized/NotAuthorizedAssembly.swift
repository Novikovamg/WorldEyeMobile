//
//  NotAuthorizedAssembly.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 14.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Swinject

final class NotAuthorizedAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(RegistrationViewModel.self) { (resolver) in
            let p = resolver.resolve(CurrentUserPersistence.self)!
            return RegistrationViewModelImp(userPersistence: p)
        }
        container.register(AuthorizationViewModel.self) { (resolver) in
            let p = resolver.resolve(CurrentUserPersistence.self)!
            return AuthorizationViewModelImp(userPersistence: p)
        }
    }
}
