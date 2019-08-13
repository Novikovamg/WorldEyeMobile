//
//  AppDelegate.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var initialCoordinator: InitialCoordinator!
    var appAssembly: AppAssembly!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        Appearance().setUp()
        appAssembly = AppAssembly()
        initialCoordinator = InitialCoordinator(appAssembly: appAssembly)
        initialCoordinator.start()
        return true
    }
}

