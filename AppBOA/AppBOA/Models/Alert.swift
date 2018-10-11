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

class Alert: Object {
    
    @objc dynamic var rowNum: Int = 0
    @objc dynamic var empleadoID: Int = 0
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
    @objc dynamic var tipo: Int = 0
    //aumentadas para alertas por aprpbar
    @objc dynamic var fechaLeido: String?
    @objc dynamic var usRemitente: Int = 0
    @objc dynamic var estadoID: Int = 0
    @objc dynamic var tipoAlertaId: Int = 0
    @objc dynamic var acciones: String?
    @objc dynamic var fechaUltimoAcceso: String?
    @objc dynamic var remitente: String?
    @objc dynamic var destinatario: String?
    @objc dynamic var itemDestinatario: String?
    @objc dynamic var usDestinatario: Int = 0
    @objc dynamic var itemUsDestinatario: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init(alert: [String: Any]) {
        self.init()
        self.rowNum = alert["RowNum"] as? Int ?? 0
        self.empleadoID = alert["empleadoID"] as? Int ?? 0
        self.titulo = alert["Titulo"] as? String
        self.descripcionCorta = alert["DescripcionCorta"] as? String
        self.sistemaOrigen = alert["SistemaOrigen"] as? String
        self.sistemaId = alert["SistemaId"] as? Int ?? 0
        self.cantAlertas = alert["CantAlertas"] as? Int ?? 0
        self.codigo = alert["codigo"] as? Int ?? 0
        self.mensaje = alert["mensaje"] as? String
        self.descripcion = alert["Descripcion"] as? String
        self.alertaID = alert["AlertaID"] as? Int ?? 0
        self.fecha = alert["Fecha"] as? String
        self.estadoAlertaId = alert["EstadoAlertaId"] as? Int ?? 0
        self.tipo = alert["Tipo"] as? Int ?? 0
        //aumentadas para alertas por aprpbar
        self.fechaLeido = alert["FechaLeido"] as? String
        self.usRemitente = alert["UsRemitente"] as? Int ?? 0
        self.estadoID = alert["EstadoId"] as? Int ?? 0
        self.tipoAlertaId = alert["TipoAlertaId"] as? Int ?? 0
        self.acciones = alert["Acciones"] as? String
        self.fechaUltimoAcceso = alert["FechaUltimoAcceso"] as? String
        self.remitente = alert["remitente"] as? String
        self.destinatario = alert["destinatario"] as? String
        self.itemDestinatario = alert["itemDestinatario"] as? String
        self.usDestinatario = alert["usDestinatario"] as? Int ?? 0
        self.itemUsDestinatario = alert["itemUsDestinatario"] as? Int ?? 0
        
    }
}
