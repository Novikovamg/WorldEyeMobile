//
//  Entry.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import RealmSwift

class Entry: Object {
    static var type = Entry.self
    
    @objc dynamic var id: String = ""
    
    override static func primaryKey() -> String? { return "id" }
}
