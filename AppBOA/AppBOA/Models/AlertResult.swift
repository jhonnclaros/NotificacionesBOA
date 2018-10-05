//
//  AlertResult.swift
//  AppBOA
//
//  Created by Danitza on 10/4/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm
import ObjectMapperAdditions

class AlertResult: Object, Mappable {
    
    /*@objc dynamic var serverRoot: String?
     var headers: List<String> = List<String>()
     var links: List<String> = List<String>()
     
     //var GetAlertasAgrupadasResult: String?
     
     required convenience init?(map: Map) {
     self.init()
     }
     
     func mapping(map: Map) {
     serverRoot <- map["serverRoot"]
     headers <- (map["headers"], RealmTypeCastTransform())
     links <- (map["_links"], RealmTypeCastTransform())
     }*/
    //@objc dynamic var getAlertasAgrupadasResult: Lista?
    
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map.JSON["GetAlertasAgrupadasResult"] as! Map)
    }
    
    func mapping(map: Map) {
       // getAlertasAgrupadasResult <- map["GetAlertasAgrupadasResult"]
    }
}

