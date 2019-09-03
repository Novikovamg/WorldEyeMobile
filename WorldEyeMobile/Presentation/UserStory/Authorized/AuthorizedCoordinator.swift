//
//  AuthorizedCoordinator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 03.09.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

final class AuthorizedCoordinator: Coordinator {
    
    // MARK: Initializer
    
    override init() {
        tabBarController = UITabBarController()
        UIApplication.shared.windows.first?.rootViewController = tabBarController
        
    }
    
    // MARK: Public
    
    public func start() {
        let mapCoordinator = MapPostCoordinator()
        addChild(flow: mapCoordinator)
        let mapPostViewController = mapCoordinator.start()
        
        let friendsCoordinator = FriendsCoordinator()
        addChild(flow: friendsCoordinator)
        let friendsViewController = friendsCoordinator.start()
        
        let profileCoordinator = ProfileCoordinator()
        addChild(flow: profileCoordinator)
        let profileViewController = profileCoordinator.start()
        
        tabBarController.setViewControllers([mapPostViewController,
                                             friendsViewController,
                                             profileViewController],
                                            animated: false)
    }
    
    
    // MARK: Private
    
    private let tabBarController: UITabBarController
    
}
