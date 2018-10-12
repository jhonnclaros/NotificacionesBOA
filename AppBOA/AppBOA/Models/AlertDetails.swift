//
//  AlertDetails.swift
//  AppBOA
//
//  Created by macmini on 10/12/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm
import ObjectMapperAdditions

class AlertDetails: Object, Mappable {
   
    @objc dynamic var rowNum: Int = 0
    @objc dynamic var titulo: String?
    @objc dynamic var descripcionCorta: String?
    @objc dynamic var fecha: String?
    @objc dynamic var sistemaOrigen: String?
    @objc dynamic var estadoAlerta: String?
    @objc dynamic var fechaLeido: String?
    @objc dynamic var usRemitente: Int = 0
    @objc dynamic var alertaID: Int = 0
    @objc dynamic var estadoID: Int = 0
    @objc dynamic var tipoAlertaId: Int = 0
    @objc dynamic var sistemaId: Int = 0
    @objc dynamic var acciones: String?
    @objc dynamic var fechaUltimoAcceso: String?
    @objc dynamic var remitente: String?
    @objc dynamic var destinatario: String?
    @objc dynamic var itemDestinatario: String?
    @objc dynamic var descripcion: String?
    @objc dynamic var usDestinatario: Int = 0
    @objc dynamic var itemUsDestinatario: Int = 0
    @objc dynamic var estadoAlertaId: Int = 0
    @objc dynamic var codigo: Int = 0
    @objc dynamic var mensaje: String?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        let mapAlert = map.JSON["GetDetalleAlertaResult"] as! String
        let data = mapAlert.data(using: .utf8)!
        do{
            let output = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            
            self.rowNum = output!["RowNum"] as? Int ?? 0
            self.titulo = output!["Titulo"] as? String
            self.descripcionCorta = output!["DescripcionCorta"] as? String
            self.fecha = output!["Fecha"] as? String
            self.sistemaOrigen = output!["SistemaOrigen"] as? String
            self.estadoAlerta = output!["EstadoAlerta"] as? String
            self.fechaLeido = output!["FechaLeido"] as? String
            self.usRemitente = output!["UsRemitente"] as? Int ?? 0
            self.alertaID = output!["AlertaId"] as? Int ?? 0
            self.estadoID = output!["EstadoId"] as? Int ?? 0
            self.tipoAlertaId = output!["TipoAlertaId"] as? Int ?? 0
            self.sistemaId = output!["SistemaId"] as? Int ?? 0
            self.acciones = output!["Acciones"] as? String
            self.fechaUltimoAcceso = output!["FechaUltimoAcceso"] as? String
            self.remitente = output!["remitente"] as? String
            self.destinatario = output!["destinatario"] as? String
            self.itemDestinatario = output!["itemDestinatario"] as? String
            self.descripcion = output!["Descripcion"] as? String
            self.usDestinatario = output!["usDestinatario"] as? Int ?? 0
            self.itemUsDestinatario = output!["itemUsDestinatario"] as? Int ?? 0
            self.estadoAlertaId = output!["EstadoAlertaId"] as? Int ?? 0
            self.codigo = output!["codigo"] as? Int ?? 0
            self.mensaje = output!["mensaje"] as? String
            
        }
        catch {
            print (error)
        }
        
    }
}

