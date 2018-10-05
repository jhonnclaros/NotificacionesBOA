//
//  Lista.swift
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

class Lista: Object, Mappable {
    
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
    //var lista: List<Alert> = List<Alert>()
    @objc dynamic var totalRegistros: Int = 0
    @objc dynamic var codigo: Int = 0
    @objc dynamic var mensaje: String?
    
    required convenience init?(map: Map) {
        self.init()
        //mapping(map: map)
        mapping(map: map.JSON["GetAlertasAgrupadasResult"] )
    }
    
    func mapping(map: Map) {
        //lista <- (map["lista"], RealmTypeCastTransform())
        totalRegistros <- map["totalRegistros"]
        codigo <- map["codigo"]
        mensaje <- map["mensaje"]
    }
}
