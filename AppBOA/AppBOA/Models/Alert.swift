//
//  Alert.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 27/9/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm
import ObjectMapperAdditions

class Alert: Object, Mappable {
    
    @objc dynamic var serverRoot: String?
    var headers: List<String> = List<String>()
    var links: List<String> = List<String>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        serverRoot <- map["serverRoot"]
        headers <- (map["headers"], RealmTypeCastTransform())
        links <- (map["_links"], RealmTypeCastTransform())
    }
}
