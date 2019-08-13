//
//  ResponseUserTranslator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation

final class ResponseUserTranslator {
    static func toEntity(from response: ResponseAuthorized) -> User {
        return User(id: response.id,
                    name: response.name,
                    login: response.login,
                    email: response.email)
    }
}
