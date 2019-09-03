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
        authorizationViewModel = assembly.resolve(AuthorizationViewModel.self)
        authorizationViewController = AuthorizationViewController(viewModel: authorizationViewModel)
        authorizationViewController.delegate = self
        navigationController = UINavigationController(rootViewController: authorizationViewController)
        UIApplication.shared.windows.first?.rootViewController = navigationController
    }
    
    private var authorizationViewController: AuthorizationViewController!
    private var authorizationViewModel: AuthorizationViewModel!
}

extension AuthorizationCoordinator: AuthorizationViewControllerDelegate {
    func registrate() {
        let coordinator = RegistrationCoordinator()
        coordinator.registrationCoordinatorDelegate = self
        self.addChild(flow: coordinator, with: navigationController)
        coordinator.start()
    }
    
    func logedIn() {
        delegate?.finish(flow: self)
    }
}

extension AuthorizationCoordinator: RegistrationCoordinatorDelegate {
    func registered() {
        delegate?.finish(flow: self)
    }
}
