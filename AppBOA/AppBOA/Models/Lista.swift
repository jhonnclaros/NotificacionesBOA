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
    var lista: [Alert] = []
    @objc dynamic var totalRegistros: Int = 0
    @objc dynamic var codigo: Int = 0
    @objc dynamic var mensaje: String?
    
    required convenience init?(map: Map) {
        self.init()
        //mapping(map: map)
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        let map1 = map.JSON["GetAlertasAgrupadasResult"] as! String
        let data = map1.data(using: .utf8)!
        do{
            let output = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            print ("\(String(describing: output))")
            totalRegistros = output!["totalRegistros"] as! Int
            codigo = output!["codigo"] as! Int
            mensaje = output!["totalRegistros"] as? String
            lista = getAlertList(data: (output!["lista"] as? [[String: Any]])!)
        }
        catch {
            print (error)
        }
        
    }
    
    func getAlertList(data: [[String: Any]]) -> [Alert] {
        var alertList: [Alert] = []
        for alert in data {
            alertList.append(Alert(alert: alert))
            //alertList.append(alert)
        }
        return alertList
    }
}
