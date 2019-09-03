//
//  FriendsCoordinator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 03.09.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

final class FriendsCoordinator: Coordinator {
    
    func start() -> UIViewController {
        friendsViewModel = assembly.resolve(FriendsViewModel.self)
        friendsViewController = FriendsViewController(viewModel: friendsViewModel)
        return friendsViewController
    }
    
    private var friendsViewModel: FriendsViewModel!
    private var friendsViewController: FriendsViewController!
}
