//
//  EMAccount.swift
//  Evolve.Markets
//
//  Created by atao1 on 6/1/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class EMAccount: Mappable {
    
    var accountType: String?
    var balance: Double?
    var decimals: Int?
    var denomination: String?
    var group: String?
    var leverage: Int?
    var metaID: Int?
    var name: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        accountType <- map["type"]
        balance <- map["balance"]
        decimals <- map["decimals"]
        denomination <- map["denomination"]
        group <- map["group"]
        leverage <- map["leverage"]
        metaID <- map["mt5id"]
        name <- map["name"]
        
    }
}
