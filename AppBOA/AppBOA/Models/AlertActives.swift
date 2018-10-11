//
//  AlertActives.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 11/10/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm
import ObjectMapperAdditions

class AlertActives: Object, Mappable {
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map.JSON["GetAlertasResult"] as! Map)
    }
    
    func mapping(map: Map) {
        // getAlertasAgrupadasResult <- map["GetAlertasAgrupadasResult"]
    }
}
