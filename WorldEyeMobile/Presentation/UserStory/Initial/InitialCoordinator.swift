//
//  InitialCoordinator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

final class InitialCoordinator: Coordinator {
    
    // MARK: Initializer
    
    init(appAssembly: AppAssembly) {
        userPersistence = appAssembly.resolve(CurrentUserPersistence.self)
        super.init()
        assembly = appAssembly
    }
    
    // MARK: Public
    
    public func start() {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
        }
        if userPersistence.isAuthorized {
            startAuthorizedModule()
        } else {
            startNotAuthorizedModule()
        }
    }
    
    // MARK: Private
    
    private var window: UIWindow!
    
    private var userPersistence: CurrentUserPersistence
    
    private func startNotAuthorizedModule() {
        let coordinator = AuthorizationCoordinator()
        self.addChild(flow: coordinator)
        coordinator.start()
    }
    
    private func startAuthorizedModule() {
        let coordinator = AuthorizedCoordinator()
        self.addChild(flow: coordinator)
        coordinator.start()
    }
    
    override func finish(flow: Coordinator) {
        if flow is AuthorizationCoordinator {
            startAuthorizedModule()
        }
        super.finish(flow: flow)
    }
}
