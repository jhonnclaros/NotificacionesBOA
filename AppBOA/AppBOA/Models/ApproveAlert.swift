//
//  ApproveAlert.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 16/10/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm
import ObjectMapperAdditions

class ApproveAlert: Object, Mappable {
    
    @objc dynamic var esValido: Int = 0
    @objc dynamic var descripcion: String?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        let mapAlert = map.JSON["AprobarAlertaResult"] as! String
        let data = mapAlert.data(using: .utf8)!
        do{
            let output = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            esValido = output!["EsValido"] as! Int
            descripcion = output!["Descripcion"] as? String
        }
        catch {
            print (error)
        }
    }
}
