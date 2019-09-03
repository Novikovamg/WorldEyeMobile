//
//  ResponsePost.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 15.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

struct ResponsePost: Decodable {
    var id: String
    var longitude: Float
    var latitude: Float
    var title: String
    var text: String
}

