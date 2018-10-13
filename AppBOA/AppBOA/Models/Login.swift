//
//  Login.swift
//  AppBOA
//
//  Created by Danitza on 10/12/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm
import ObjectMapperAdditions

class Login: Object, Mappable {
    
    @objc dynamic var codigo: Int = 0
    @objc dynamic var mensaje: String?
    @objc dynamic var objeto: String?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        let mapAlert = map.JSON["AutentificarUsuarioResult"] as! String
        let data = mapAlert.data(using: .utf8)!
        do{
            let output = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            
            self.codigo = output!["codigo"] as? Int ?? 0
            self.mensaje = output!["mensaje"] as? String
            self.objeto = output!["objeto"] as? String
            
        }
        catch {
            print (error)
        }
        
    }
}


