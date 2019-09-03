//
//  Assembly.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Swinject

final class AppAssembly {
    
    public let assembler: Assembler
    
    public func resolve<Protocol>(_ protcol: Protocol.Type) -> Protocol {
        if let resolved = assembler.resolver.resolve(protcol) {
            return resolved
        } else {
            fatalError("Unresolved type: \(Protocol.self)")
        }
    }
    
    init() {
        let coreAssembler = Assembler([StorageAssembly()])
        let sourceAssembler = Assembler([PersistenceAssembly()], parent: coreAssembler)
        assembler = Assembler([NotAuthorizedAssembly(),
                               MapPostAssembly(),
                               FriendsAssembly()
                              ],
                              parent: sourceAssembler)
    }
}

