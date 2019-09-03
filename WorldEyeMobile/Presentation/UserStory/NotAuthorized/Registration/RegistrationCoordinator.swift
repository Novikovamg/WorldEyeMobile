//
//  RegistrationCoordinator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 14.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

protocol RegistrationCoordinatorDelegate: AnyObject {
    func registered()
}

final class RegistrationCoordinator: Coordinator {
    
    public weak var registrationCoordinatorDelegate: RegistrationCoordinatorDelegate?
    
    public func start() {
        registrationViewModel = assembly.resolve(RegistrationViewModel.self)
        registrationViewController = RegistrationViewController(viewModel: registrationViewModel)
        registrationViewController.delegate = self
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    private var registrationViewModel: RegistrationViewModel!
    private var registrationViewController: RegistrationViewController!
}

extension RegistrationCoordinator: RegistrationViewControllerDelegate {
    func registered() {
        registrationCoordinatorDelegate?.registered()
    }
}
