//
//  ProfileViewModel.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 03.09.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProfileViewModel {
    var name: Driver<String> { get }
    func logout()
}

final class ProfileViewModelImp: ProfileViewModel {
    
    // MARK: ProfileViewModel
    
    public lazy var name: Driver<String> = {
        return userStorage.current
            .map({$0.name})
            .asDriver(onErrorJustReturn: "")
    }()
    
    public func logout() {
        currentUserPersistence.logout()
    }
    
    // MARK: Initializer
    
    init(currentUserPersistence: CurrentUserPersistence,
         userStorage: UserStorage)
    {
        self.currentUserPersistence = currentUserPersistence
        self.userStorage = userStorage
    }
    
    // MARK: Private
    
    private let currentUserPersistence: CurrentUserPersistence
    
    private let userStorage: UserStorage
}
