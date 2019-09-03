//
//  Appereance.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit
import GoogleMaps
import RealmSwift

final class Settings {
    
    public func setUp() {
        navigationBar()
        map()
        realm()
    }
    
    private func navigationBar() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = .black
        let navigationBarFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                       NSAttributedString.Key.font: navigationBarFont]
        navigationBarAppearance.shadowImage = UIImage()
        navigationBarAppearance.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    private func map() {
        GMSServices.provideAPIKey("AIzaSyCQ8RmcLAMlD1DSfQc7lFWGZ4xwxqhjnUw")
    }
    
    private func realm() {
        var config = Realm.Configuration.defaultConfiguration
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        
        #if DEBUG
            print(config)
        #endif
    }
}
