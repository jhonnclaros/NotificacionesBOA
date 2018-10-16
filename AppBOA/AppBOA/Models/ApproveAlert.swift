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

class ApproveAlert: Object {
    
    @objc dynamic var idAlerta: Int = 0
    @objc dynamic var sistemaID: Int = 0
    @objc dynamic var empleadoID: Int = 0
    @objc dynamic var empleadoIDAprobador: Int = 0
    @objc dynamic var tipoAprobacion: Int = 0
    @objc dynamic var tipoFormulario: Int = 0
    @objc dynamic var observacion: String?
    @objc dynamic var Ip: String?
    @objc dynamic var Titulo: String?
    @objc dynamic var DescripcionCorta: String?
    @objc dynamic var DescripcionCortaLarga: String?

}
