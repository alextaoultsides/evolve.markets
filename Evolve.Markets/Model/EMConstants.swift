//
//  EMConstants.swift
//  Evolve.Markets
//
//  Created by atao1 on 6/13/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation

extension EMClient {
    struct Constants {
        struct ApiMethods {
            static let demoPostMethod = "https://mt5.clients.evolve.markets/api/account/deposit/"
            static let updateAccountMethod = "https://mt5.clients.evolve.markets/api/account/update/"
            static let deleteAccountMethod = "https://mt5.clients.evolve.markets/api/account/delete/"
            static let logoutUserMethod = "https://mt5.clients.evolve.markets/logout/"
        }
    }
}
