//
//  AuthorizationViewModel.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

protocol AuthorizationViewModel {
    func login(username: String, password: String, onSuccess: @escaping () -> Void)
}

final class AuthorizationViewModelImp: AuthorizationViewModel {
    
    // MARK: Initializer
    
    init(userPersistence: CurrentUserPersistence) {
        self.userPersistence = userPersistence
    }

    // MARK: AuthorizationViewModel
    
    public func login(username: String, password: String, onSuccess: @escaping () -> Void) {
        userPersistence.login(username: username, password: password,
        onComplete: { [weak self] (result) in
            switch result {
            case .success:
                onSuccess()
            case .failure:
                // TODO: Viewving UI message
                ()
            }
        })
    }
    
    // MARK: Private
    
    private var userPersistence: CurrentUserPersistence
}
