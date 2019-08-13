
//
//  Swe.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Swinject

final class ServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        assembleAuthorizationService(container)
    }
    
    private func assembleAuthorizationService(_ container: Container) {
        container.register(AuthorizationService.self){ (_: Resolver) in
            return AuthorizationServiceImp()
        }.inObjectScope(.transient)
    }
    
    private func assembleRegistrationService(_ container: Container) {
        container.register(RegistrationService.self){ (_: Resolver) in
            return RegistrationServiceImp()
        }.inObjectScope(.transient)
    }
}
