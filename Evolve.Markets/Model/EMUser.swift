//
//  EMUser.swift
//  Evolve.Markets
//
//  Created by atao1 on 5/30/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class EMUser: Mappable {
    
    var accountDemo: [EMAccount]?
    var accountLive: [EMAccount]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        accountDemo <- map["data.accounts.demo"]
        accountLive <- map["data.accounts.live"]
        
    }
}
