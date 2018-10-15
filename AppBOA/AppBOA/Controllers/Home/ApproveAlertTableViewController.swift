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
    var alerts = [Alert]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        title = "Aprobar Alertas"
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Processing"
        APIManager.getApproveAlertList(generateSending(), success: { (alerts: [Alert]) in
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
    
    @IBAction func countAction(_ sender: UIButton) {
        performSegue(withIdentifier: "CountSegue", sender: nil)
    }
    
    @IBAction func receiveAction(_ sender: UIButton) {
        performSegue(withIdentifier: "ReceiveSegue", sender: nil)
    }
    
    @IBAction func approveAlert(_ sender: UIButton) {
        let title = selectedAlert?.titulo
        showAlert(title: "Aprobar Alerta", message: "Esta Seguro de Aprobar el Permiso?")
    }
    
    @IBAction func rejectAlert(_ sender: UIButton) {
        showAlert(title: "Rechazar Alerta", message: "Esta Seguro de Rechazar el Permiso?")
    }
    
    func showAlert(title: String, message: String) {
        let messageAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let approveAction = UIAlertAction(title: "Aprobar", style: .default) { (action) in
            /*self.mensajeLabel.text = "Barcelona es una ciudad española, capital de la comunidad autónoma de Cataluña, de la comarca del Barcelonés y de la provincia homónima. Población: 1,609 millones (2016)"*/
        }
        let rejectAction = UIAlertAction(title: "Cancelar", style: .default, handler: {(action) in
            //self.mensajeLabel.text = ""
        })
        messageAlert.addAction(approveAction)
        messageAlert.addAction(rejectAction)
        present(messageAlert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertApproveCell", for: indexPath) as! AlertApproveTableViewCell
        
        let tituloAlerta: String = alerts[indexPath.row].titulo ?? ""
        let fechaAlerta: String = alerts[indexPath.row].fecha ?? ""
        let sistemaOrigen: String = alerts[indexPath.row].sistemaOrigen ?? ""
        cell.typeAlertLabel.text = fechaAlerta + " - " + sistemaOrigen
        cell.titleAlertLabel.text = tituloAlerta
        //cell.accessoryType = .disclosureIndicator
        /*if alerts[indexPath.row].alertaID > 0 {
            //cell.accessoryType = .detailDisclosureButton
            cell.titleAlertNameLabel.text = fechaAlerta + " - " + tituloAlerta
        }*/
        cell.shortDescriptionLabel.text = alerts[indexPath.row].descripcionCorta
        cell.longDescriptionLabel.text = alerts[indexPath.row].descripcion
        
        return cell
        
    }
}
