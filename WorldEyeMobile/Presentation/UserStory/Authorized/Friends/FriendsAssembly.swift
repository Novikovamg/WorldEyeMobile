//
//  FriendsAssembly.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 03.09.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Swinject

final class FriendsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(FriendsViewModel.self) { (resolver) in
            return FriendsViewModelImp()
        }
    }
}
