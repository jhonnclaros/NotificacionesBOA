//
//  UserInfo.swift
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

class UserInfo: Object, Mappable {
    
    @objc dynamic var employeeID: Int = 0
    @objc dynamic var employeeName: String?
    @objc dynamic var userName: String?
    @objc dynamic var itemID: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        let mapAlert = map.JSON["GetUserInfoResult"] as! String
        let data = mapAlert.data(using: .utf8)!
        do{
            let output = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            
            self.employeeID = output!["empleadoID"] as? Int ?? 0
            self.employeeName = output!["NombreEmpleado"] as? String
            self.userName = output!["usuario"] as? String
            self.itemID = output!["itemID"] as? Int ?? 0
            
        }
        catch {
            print (error)
        }
        
    }
}
