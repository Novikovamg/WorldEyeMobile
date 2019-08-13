//
//  DAO.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import RealmSwift
import RxRealm

struct DAO<E: Entry> {
    
    // MARK: Properties
    
    var translator: Translator
    
    // MARK: Initialization
    
    init(translator: Translator) {
        self.translator = translator
    }
    
    // MARK: Persist
    
    @discardableResult
    func persist(withEntities entities: [Entity]) -> Bool {
        let entries = translator.toEntries(withEntities: entities)
        do {
            let realm = try Realm()
            try realm.write { realm.add(entries, update: .all) }
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    func persist(withEntity entity: Entity) -> Bool {
        let entry = translator.toEntry(withEntity: entity)
        do {
            let realm = try Realm()
            try realm.write { realm.add(entry, update: .all) }
            return true
        } catch {
            return false
        }
    }
    
    // MARK: Read
    
    func read() -> [Entity] {
        do {
            let realm = try Realm()
            let objects = realm.objects(E.self)
            return translator.toEntities(withEntries: objects.map { $0 })
        } catch {
            return []
        }
    }
    
    func read(byID id: String) -> Entity? {
        do {
            let realm = try Realm()
            let object = realm.object(ofType: E.self, forPrimaryKey: id)
            if let entry = object {
                return translator.toEntity(withEntry: entry)
            } else {
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    func read(withParameters parameters: [String: Any]) -> [Entity] {
        do {
            var strings = [String]()
            for (key, value) in parameters {
                if let value = value as? String {
                    strings.append("\(key) CONTAINS[c] '\(value)'")
                } else {
                    strings.append("\(key) = \(value)")
                }
            }
            // TODO: This is not good, sometimes it is required to have OR logic
            let filterString = strings.joined(separator: " AND ")
            let realm = try Realm()
            var objects = realm.objects(E.self)
            objects = objects.filter(filterString)
            return translator.toEntities(withEntries: objects.map { $0 })
        } catch {
            return []
        }
    }
    
    func readVar(ofElemntWith id: String, named: String, _ translator: Translator) -> Entity? {
        do {
            let realm = try Realm()
            let object = realm.object(ofType: E.self, forPrimaryKey: id)
            let array = object?.value(forKey: named) as? Entry
            if let array = array {
                return translator.toEntity(withEntry: array)
            } else {
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    func readArr<T: Entry>(ofElemntWith id: String, named: String, arrEntryType: T.Type, _ translator: Translator) -> [Entity] {
        do {
            let realm = try Realm()
            let object = realm.object(ofType: E.self, forPrimaryKey: id)
            if let enty = object {
                if let list = enty.value(forKey: named) as? List<T> {
                    let array = list.toArray()
                    return translator.toEntities(withEntries: array)
                } else {
                    return []
                }
            } else {
                return []
            }
        } catch {
            print(error)
            return []
        }
    }
    
    // MARK: Erase
    
    @discardableResult
    func erase() -> Bool {
        do {
            let realm = try Realm()
            let objects = realm.objects(E.self)
            try realm.write { realm.delete(objects) }
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    func erase(byID id: String) -> Bool {
        do {
            let realm = try Realm()
            let object = realm.object(ofType: E.self, forPrimaryKey: id)
            if let object = object {
                try realm.write { realm.delete(object) }
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

