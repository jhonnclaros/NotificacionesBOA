//
//  ServerError.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 26/9/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import RealmSwift


class ServerError: Object {
    
    @objc dynamic var code: String?
    @objc dynamic var date: String?
    @objc dynamic var desc: String?
    @objc dynamic var value: String?
    var errorsList: List<ServerError> = List<ServerError>()
    
    convenience init(error: [String:Any]) {
        self.init()
        self.code = (error["code"] as? String ?? "")
        self.date = (error["date"] as? String ?? "")
        self.desc = (error["description"] as? String ?? "")
        self.value = (error["value"] as? String ?? "")
    }
    
}
