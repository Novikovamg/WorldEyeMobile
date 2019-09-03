//
//  MapPostAssembly.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 14.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Swinject

final class MapPostAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MapPostViewModel.self) { (resolver) in
            return MapPostViewModelImp()
        }
    }
}
