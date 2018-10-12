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
    
    var lista: [Alert] = []
    @objc dynamic var totalRegistros: Int = 0
    @objc dynamic var codigo: Int = 0
    @objc dynamic var mensaje: String?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        let mapAlert = map.JSON["GetAlertasAgrupadasResult"] as! String
        let data = mapAlert.data(using: .utf8)!
        do{
            let output = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            totalRegistros = output!["totalRegistros"] as! Int
            codigo = output!["codigo"] as! Int
            mensaje = output!["mensaje"] as? String
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
        }
        return alertList
    }
}
