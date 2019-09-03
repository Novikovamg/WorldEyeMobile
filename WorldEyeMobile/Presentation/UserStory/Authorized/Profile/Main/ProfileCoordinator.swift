//
//  ProfileCoordinator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 03.09.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    func start() -> UIViewController {
        profileViewModel = assembly.resolve(ProfileViewModel.self)
        profileViewController = ProfileViewController(viewModel: profileViewModel)
        return profileViewController
    }
    
    private var profileViewModel: ProfileViewModel!
    private var profileViewController: ProfileViewController!
}
