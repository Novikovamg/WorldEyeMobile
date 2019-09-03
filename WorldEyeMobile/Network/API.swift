//
//  API.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Swinject

final class API {
    
    static var assembler = Assembler([ServiceAssembly()])
    
    private init() {}
    
    static var settings: APISettings = APISettings.init()
    
    static var auth: AuthorizationService { return assembler.resolver.resolve(AuthorizationService.self)! }
    static var registration: RegistrationService { return assembler.resolver.resolve(RegistrationService.self)! }
    static var post: PostService { return assembler.resolver.resolve(PostService.self)! }
}

struct APISettings {
    var requestToken: String?
}
