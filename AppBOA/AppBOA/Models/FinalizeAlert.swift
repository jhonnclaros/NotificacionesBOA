//
//  FinalizeAlert.swift
//  AppBOA
//
//  Created by Danitza on 11/6/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm
import ObjectMapperAdditions

class FinalizeAlert: Object, Mappable {
    
    @objc dynamic var esValido: Int = 0
    @objc dynamic var descripcion: String?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        let mapObject = map.JSON["AlertaFinalizadoResult"] as! String
        let data = mapObject.data(using: .utf8)!
        do{
            let output = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            
            self.esValido = output!["EsValido"] as? Int ?? 0
            self.descripcion = output!["Descripcion"] as? String
        }
        catch {
            print (error)
        }
        
    }
}
