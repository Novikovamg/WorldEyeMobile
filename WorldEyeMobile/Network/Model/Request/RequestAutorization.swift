//
//  RequestAutorization.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

struct RequestAutorization: Encodable {
    var login: String
    var password: String
}

struct RequestRegistration: Encodable {
    var login: String
    var email: String
    var name: String
    var password: String
}
