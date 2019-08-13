//
//  InitialCoordinator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

final class InitialCoordinator: Coordinator {
    
    var window: UIWindow!
    
    init(appAssembly: AppAssembly) {
        super.init()
        self.assembly = appAssembly
    }
    
    func start() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = InitialViewController()
        vc.delegate = self
        window.rootViewController = vc
        self.window = window
        window.makeKeyAndVisible()
    }
}

extension InitialCoordinator: InitialViewControllerDelegate {
    func logedIn() {
        
    }
    
    func logedOut() {
        let authCoordinator = AuthorizationCoordinator()
        addChild(flow: authCoordinator)
        authCoordinator.start()
    }
}
