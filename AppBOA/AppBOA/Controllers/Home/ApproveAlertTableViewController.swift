//
//  ApproveAlertTableViewController.swift
//  AppBOA
//
//  Created by Danitza on 10/10/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import Alamofire
import AlamofireObjectMapper
import Reachability


class ApproveAlertTableViewController: UITableViewController {
    
    var selectedAlert: Alert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        title = "Aprobar Alertas"
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Processing"
        APIManager.getApproveAlertsList(generateSending(), success: { (alerts: [Alert]) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.alerts = alerts
            self.tableView.reloadData()
            
            
        }, failure: { (error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            var errorMessage = Constants.Error.InternalServerMessage
            var titleMessage = Constants.Error.ErrorInternalServerTitle
            if error != nil {
                errorMessage = (error?.desc)!
                titleMessage = "AppBoa"
            }
            AlertManager.showAlert(from: self, title: titleMessage, message: errorMessage, buttonStyle: .default)
        })
    }
    
    func generateSending() -> [String: Any] {
        var body: [String: Any] = [:]
        body["credenciales"] = ""
        body["idSistema"] = selectedAlert?.sistemaId
        body["filtro"] = ""
        body["empleadoID"] = selectedAlert?.empleadoID
        body["estado"] = "0"
        body["pagina"] = "1"
        body["fechaIni"] = ""
        body["fechaFin"] = ""
        body["busquedaHistorialint"] = "0"
        body["paginacion_size"] = "1000"
        body["tipoAlerta"] = "2"
        body["Tipo"] = selectedAlert?.tipo
        return body
    }
}
