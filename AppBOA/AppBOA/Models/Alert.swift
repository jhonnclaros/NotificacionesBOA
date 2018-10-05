//
//  Alert.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 27/9/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm
import ObjectMapperAdditions

class Alert: Object, Mappable {
    
    @objc dynamic var rowNum: Int = 0
    /*@objc dynamic var empleadoID: Int = 0
    @objc dynamic var titulo: String?
    @objc dynamic var descripcionCorta: String?
    @objc dynamic var sistemaOrigen: String?
    @objc dynamic var sistemaId: Int = 0
    @objc dynamic var cantAlertas: Int = 0
    @objc dynamic var codigo: Int = 0
    @objc dynamic var mensaje: String?
    @objc dynamic var descripcion: String?
    @objc dynamic var alertaID: Int = 0
    @objc dynamic var fecha: String?
    @objc dynamic var estadoAlertaId: Int = 0
    @objc dynamic var tipo: Int = 0*/
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        rowNum <- map["RowNum"]
        /*empleadoID <- map["empleadoID"]
        titulo <- map["Titulo"]
        descripcionCorta <- map["DescripcionCorta"]
        sistemaOrigen <- map["SistemaOrigen"]
        sistemaId <- map["SistemaId"]
        cantAlertas <- map["CantAlertas"]
        codigo <- map["codigo"]
        mensaje <- map["mensaje"]
        descripcion <- map["Descripcion"]
        alertaID <- map["AlertaID"]
        fecha <- map["Fecha"]
        estadoAlertaId <- map["EstadoAlertaId"]
        tipo <- map["Tipo"]*/
    }
}
