//
//  RxDAO.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 03.09.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation
import RxRealm
import RxSwift
import RxCocoa
import RealmSwift

class RxDAO<E: Entry> {
    
    // MARK: Properties
    
    weak var disposeBag: DisposeBag?
    
    var mapArr: [String: Observable<[Entity]>] = [:]
    var mapObjct: [String: Observable<Entity>] = [:]
    var mapEntity: [String: Observable<Entity?>] = [:]
    
    init(disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
    }
    
    deinit {
        mapArr.keys.forEach({key in BackgroundWorker.shared.deleteBlock(with: key)})
        mapObjct.keys.forEach({key in BackgroundWorker.shared.deleteBlock(with: key)})
        mapEntity.keys.forEach({key in BackgroundWorker.shared.deleteBlock(with: key)})
        print("Deleted")
    }
    
    
    func changes(forObjectWithId id: String,
                 withTranslator translator: Translator) -> Observable<Entity?>
    {
        let key = "\(String(describing: E.self))-\(id)"
        if let observable = mapEntity[key] {
            return observable
        }
        let observable = Observable<Entity?>.create({ [weak self] (observer) -> Disposable in
            BackgroundWorker.shared.perform(with: key) { [weak self] in
                guard let `self` = self, let disposeBag = self.disposeBag else { return }
                
                let realm = try! Realm()
                realm.refresh()
                guard let object = realm.object(ofType: E.self, forPrimaryKey: id) else {
                    #if DEBUG
                    fatalError("Object of type \(E.self) with id \(id) not exist")
                    #else
                    return
                    #endif
                }
                
                Observable
                    .from(object: object, emitInitialValue: true)
                    .map({ (entry: E) -> Entity? in
                        let entities = translator.toEntity(withEntry: entry)
                        return entities
                    })
                    .share(replay: 1)
                    .bind(to: observer)
                    .disposed(by: disposeBag)
            }
            return Disposables.create()
        })
            .share(replay: 1)
        
        mapEntity[key] = observable
        
        return observable
    }
    
    func propertyChanges<T: Entry>(forObjectWithId id: String,
                                   named propertyName: String,
                                   ofType type: T.Type,
                                   withTranslator translator: Translator) -> Observable<Entity>
    {
        let key = "\(String(describing: type.self))-\(id)-\(propertyName)"
        if let observable = mapObjct[key] {
            return observable
        }
        let observable = Observable<Entity>.create({ [weak self] (observer) -> Disposable in
            BackgroundWorker.shared.perform(with: key) { [weak self] in
                guard let `self` = self, let disposeBag = self.disposeBag  else { return }
                
                let realm = try! Realm()
                realm.refresh()
                guard let object = realm.object(ofType: E.self, forPrimaryKey: id) else {
                    #if DEBUG
                    fatalError("Object of type \(E.self) with id \(id) not exist")
                    #else
                    return
                    #endif
                }
                
                Observable
                    .from(object: object, emitInitialValue: true, properties: [propertyName])
                    .map({ (entry: E) -> Entity in
                        guard let entry = entry.value(forKey: propertyName) as? T else {
                            fatalError()
                        }
                        let entities = translator.toEntity(withEntry: entry)
                        return entities
                    })
                    .share(replay: 1)
                    .bind(to: observer)
                    .disposed(by: disposeBag)
            }
            return Disposables.create()
        })
            .share(replay: 1)
        
        mapObjct[key] = observable
        
        return observable
    }
    
    func arrChanges<T: Entry>(forObjectWithId id: String,
                              named arrayName: String,
                              ofType type: T.Type,
                              withTranslator translator: Translator) -> Observable<[Entity]>
    {
        let key = "\(String(describing: type.self))-\(id)-\(arrayName)"
        if let observable = mapArr[key] {
            return observable
        }
        
        let observable = Observable<[Entity]>.create({ [weak self] (observer) -> Disposable in
            BackgroundWorker.shared.perform(with: key) { [weak self] in
                guard let `self` = self, let disposeBag = self.disposeBag  else { return }
                
                let realm = try! Realm()
                realm.refresh()
                guard let object = realm.object(ofType: E.self, forPrimaryKey: id) else {
                    #if DEBUG
                    fatalError("Object of type \(E.self) with id \(id) not exist")
                    #else
                    return
                    #endif
                }
                
                
                Observable
                    .from(object: object, emitInitialValue: true, properties: [arrayName])
                    .map({ (entry: E) -> [Entity] in
                        guard let entries = (entry.value(forKey: arrayName) as? List<T>)?.toArray() else {
                            fatalError()
                        }
                        let entities = translator.toEntities(withEntries: entries)
                        return entities
                    })
                    .share(replay: 1)
                    .bind(to: observer)
                    .disposed(by: disposeBag)
            }
            return Disposables.create()
        })
            .share(replay: 1)
        
        mapArr[key] = observable
        
        return observable
    }
}


class BackgroundWorker: NSObject {
    
    static let shared = BackgroundWorker()
    
    private var thread: Thread!
    private var blockMap: [String: (() -> Void)] = [:]
    
    @objc
    internal func runBlock(with key: String) { blockMap[key]?() }
    
    override private init() {
        super.init()
        let threadName = String(describing: self).components(separatedBy: .punctuationCharacters)[1]
        thread = Thread { [weak self] in
            while let `self` = self, !self.thread.isCancelled {
                print(self.blockMap.keys)
                RunLoop.current.run(
                    mode: RunLoop.Mode.default,
                    before: Date.distantFuture)
            }
            Thread.exit()
        }
        thread.name = "\(threadName)-\(UUID().uuidString)"
        thread.start()
    }
    
    public func perform(with key: String, _ block: @escaping () -> Void) {
        blockMap[key] = block
        perform(#selector(runBlock(with:)),
                on: thread,
                with: key,
                waitUntilDone: false,
                modes: [RunLoop.Mode.default.rawValue])
        
    }
    
    public func deleteBlock(with keys: [String]) {
        for key in keys {
            deleteBlock(with: key)
        }
    }
    
    public func deleteBlock(with key: String) {
        blockMap.removeValue(forKey: key)
    }
    
    public func stop() {
        thread.cancel()
    }
}

