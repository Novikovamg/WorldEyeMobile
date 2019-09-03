// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT




final class CurrentUserTranslator: Translator {

    func toEntry(withEntity entity: Translator.DAOEntity) -> Translator.DAOEntry {
        let entity = entity as! CurrentUser
        let entry = CurrentUserEntry()

        entry.id = entity.id
        entry.user = UserTranslator().toEntry(withEntity: entity.user) as? UserEntry

        return entry
    }

    func toEntity(withEntry entry: Translator.DAOEntry) -> Translator.DAOEntity {
        let entry = entry as! CurrentUserEntry
        var entity = CurrentUser(
            id: entry.id,
            user: UserTranslator().toEntity(withEntry: entry.user!) as! User
        )
        return entity
    }
}


final class PostTranslator: Translator {

    func toEntry(withEntity entity: Translator.DAOEntity) -> Translator.DAOEntry {
        let entity = entity as! Post
        let entry = PostEntry()

        entry.id = entity.id
        entry.longitude = entity.longitude
        entry.latitude = entity.latitude
        entry.title = entity.title
        entry.text = entity.text

        return entry
    }

    func toEntity(withEntry entry: Translator.DAOEntry) -> Translator.DAOEntity {
        let entry = entry as! PostEntry
        var entity = Post(
            id: entry.id,
            longitude: entry.longitude,
            latitude: entry.latitude,
            title: entry.title,
            text: entry.text
        )
        return entity
    }
}


final class UserTranslator: Translator {

    func toEntry(withEntity entity: Translator.DAOEntity) -> Translator.DAOEntry {
        let entity = entity as! User
        let entry = UserEntry()

        entry.id = entity.id
        entry.name = entity.name
        entry.login = entity.login
        entry.email = entity.email

        return entry
    }

    func toEntity(withEntry entry: Translator.DAOEntry) -> Translator.DAOEntity {
        let entry = entry as! UserEntry
        var entity = User(
            id: entry.id,
            name: entry.name,
            login: entry.login,
            email: entry.email
        )
        return entity
    }
}


