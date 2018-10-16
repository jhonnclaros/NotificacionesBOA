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
        hud.label.text = "Procesando"
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
        cell.shortDescriptionLabel.text = alerts[indexPath.row].descripcionCorta
        cell.longDescriptionLabel.text = alerts[indexPath.row].descripcion
        cell.approveAlertButton.tag = indexPath.row
        cell.rejectAlertButton.tag = indexPath.row
        
        return cell
        
    }
    
    
    @IBAction func approveAlertActionButton(_ sender: UIButton) {
        //print(alerts[sender.tag])
        showConfirmMessage(title: "", message: "Esta Seguro de Aprobar esta solicitud?", alert: alerts[sender.tag], typeFormID: 1, typeApproveID: 1, observation: "")
    }
    
    @IBAction func rejectAlertActionButton(_ sender: UIButton) {
        showConfirmMessage(title: "", message: "Esta Seguro de Rechazar esta solicitud?", alert: alerts[sender.tag], typeFormID: 1, typeApproveID: 2, observation: "rechazado")
    }
    
    func showConfirmMessage(title: String, message: String, alert: Alert, typeFormID: Int, typeApproveID: Int, observation: String) {
        let messageAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let approveAction = UIAlertAction(title: "Aceptar", style: .default) { (action) in
            //funcionalidad para aprobar o rechazar
            self.approveAlertMethod(alert: alert, typeFormID: typeFormID, typeApproveID: typeApproveID, observation: observation)
        }
        let rejectAction = UIAlertAction(title: "Cancelar", style: .default, handler: {(action) in
            //funcionalidad para cancelar sin hacer nada
            
        })
        messageAlert.addAction(approveAction)
        messageAlert.addAction(rejectAction)
        present(messageAlert, animated: true, completion: nil)
    }
    
    func approveAlertMethod(alert: Alert, typeFormID: Int, typeApproveID: Int, observation: String) {
        
        var approveAlert: ApproveAlert?
        //let approveAlert: ApproveAlert?
        approveAlert?.idAlerta = alert.alertaID
        approveAlert?.sistemaID = alert.sistemaId
        approveAlert?.empleadoID = alert.usRemitente
        approveAlert?.empleadoIDAprobador = alert.usDestinatario
        approveAlert?.tipoAprobacion = typeApproveID
        approveAlert?.tipoFormulario = typeFormID
        approveAlert?.observacion = observation
        approveAlert?.Ip = "0.0.0.0"
        approveAlert?.Titulo = nil
        approveAlert?.DescripcionCorta = nil
        approveAlert?.DescripcionCortaLarga = nil
        
        print (approveAlert as Any)
        /*do{
            let output = try JSONSerialization.jsonObject(with: alert, options: .allowFragments) as? [String:Any]
        }
        catch {
            print (error)
        }*/
    }

}
