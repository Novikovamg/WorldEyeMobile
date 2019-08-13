//
//  User.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

struct User: Entity {
    var id: String
    var name: String
    var login: String
    var email: String
}

struct CurrentUser: Entity {
    var id: String
    var user: User
}
