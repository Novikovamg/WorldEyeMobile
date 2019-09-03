//
//  Constants.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 03.09.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

enum C {
    enum Image {
        enum TabBar {
            enum Friend {
                static let active: UIImage = UIImage(named: "Contacts Pressed")!.withRenderingMode(.alwaysOriginal)
                static let disactive: UIImage = UIImage(named: "Contacts Normal")!.withRenderingMode(.alwaysOriginal)
            }
            enum MapPost {
                static let active: UIImage = UIImage(named: "Oats Pressed")!.withRenderingMode(.alwaysOriginal)
                static let disactive: UIImage = UIImage(named: "Oats Normal")!.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    enum Database {
        static let singleDBId = "AlwaysOneObject"
    }
}
