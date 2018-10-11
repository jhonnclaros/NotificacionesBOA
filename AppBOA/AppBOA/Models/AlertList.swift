//
//  AlertList.swift
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

class AlertList: Object, Mappable {
    
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
        let mapAlert = map.JSON["GetAlertasResult"] as! String
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
            //alertList.append(alert)
        }
        return alertList
    }
}

