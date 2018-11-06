//
//  ReadAlert.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 6/11/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm
import ObjectMapperAdditions

class ReadAlert: Object, Mappable {
    
    @objc dynamic var codigo: Int = 0
    @objc dynamic var mensaje: String?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        let mapObject = map.JSON["LecturaAlertaResult"] as! String
        let data = mapObject.data(using: .utf8)!
        do{
            let output = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            
            self.codigo = output!["cod"] as? Int ?? 0
            self.mensaje = output!["mensaje"] as? String
        }
        catch {
            print (error)
        }
        
    }
}
