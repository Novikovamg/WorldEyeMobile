//
//  ResponseAuthorization.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

struct ResponseAuthorized: Decodable {
    var id: String
    var login: String
    var email: String
    var name: String
}
