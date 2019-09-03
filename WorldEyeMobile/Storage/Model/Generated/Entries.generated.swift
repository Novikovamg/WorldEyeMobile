// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import RealmSwift


final class CurrentUserEntry: Entry {
    @objc dynamic var user: UserEntry?
}

final class PostEntry: Entry {
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var title: String = ""
    @objc dynamic var text: String = ""
}

final class UserEntry: Entry {
    @objc dynamic var name: String = ""
    @objc dynamic var login: String = ""
    @objc dynamic var email: String = ""
}
