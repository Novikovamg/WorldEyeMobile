//
//  AuthorizationCoordinator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

final class AuthorizationCoordinator: Coordinator {
    
    public func start() {
        authorizationViewModel = AuthorizationViewModel()
        authorizationViewController = AuthorizationViewController(viewModel: authorizationViewModel)
        navigationController = UINavigationController(rootViewController: authorizationViewController)
        UIApplication.shared.windows.first!.rootViewController = navigationController
    }
    
    private var authorizationViewController: AuthorizationViewController!
    private var authorizationViewModel: AuthorizationViewModel!
}
