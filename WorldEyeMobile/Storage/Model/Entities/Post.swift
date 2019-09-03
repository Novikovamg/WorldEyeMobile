//
//  Post.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 15.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

struct Post: Entity {
    var id: String
    var longitude: Double
    var latitude: Double
    var title: String
    var text: String
}
