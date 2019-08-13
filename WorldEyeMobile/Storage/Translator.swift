//
//  Translator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

protocol Translator {
    
    // MARK: Associated types
    
    typealias DAOEntity = Entity
    typealias DAOEntry = Entry
    
    // MARK: DB objects <-> POSO mapping
    
    /// Translate entity to object
    func toEntry(withEntity entity: DAOEntity) -> DAOEntry
    
    /// Translate object to entity
    func toEntity(withEntry entry: DAOEntry) -> DAOEntity
    
    /// Translate array of Entity to database Objects array
    func toEntries(withEntities entities: [DAOEntity]) -> [DAOEntry]
    
    /// Translate array of database Objects to Entity array
    func toEntities(withEntries entries: [DAOEntry]) -> [DAOEntity]
}

extension Translator {
    func toEntries(withEntities entities: [DAOEntity]) -> [DAOEntry] {
        return entities.map { toEntry(withEntity: $0) }
    }
    
    func toEntities(withEntries entries: [DAOEntry]) -> [DAOEntity] {
        return entries.map { toEntity(withEntry: $0) }
    }
}
