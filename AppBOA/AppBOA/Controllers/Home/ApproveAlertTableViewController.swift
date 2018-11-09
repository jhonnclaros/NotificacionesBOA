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
    var reloadTimer: Timer!
    var refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTimer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(reloadTableView), userInfo: nil, repeats: true)
        setupRefreshControl()
        loadData()
    }
    
    func loadData() {
        title = "Aprobar Alertas"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
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
    
    @objc func reloadTableView() {
        loadData()
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
        var strDescripcion = alerts[indexPath.row].descripcion
        strDescripcion = strDescripcion?.replacingOccurrences(of: "<br>", with: "\n")
        let tituloAlerta: String = alerts[indexPath.row].titulo ?? ""
        let fechaAlerta: String = alerts[indexPath.row].fecha ?? ""
        let sistemaOrigen: String = alerts[indexPath.row].sistemaOrigen ?? ""
        cell.typeAlertLabel.text = fechaAlerta + " - " + sistemaOrigen
        cell.titleAlertLabel.text = tituloAlerta
        cell.shortDescriptionLabel.text = alerts[indexPath.row].descripcionCorta
        cell.longDescriptionLabel.text = strDescripcion
        cell.approveAlertButton.tag = indexPath.row
        cell.rejectAlertButton.tag = indexPath.row
        
        return cell
        
    }
    
    func setupRefreshControl() {
        refresher.attributedTitle = NSAttributedString(string: "Refrescar")
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refresher)
    }
    
    @objc func refresh(_ sender: Any) {
        loadData()
        refresher.endRefreshing()
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
            self.loadData()
        })
        messageAlert.addAction(approveAction)
        messageAlert.addAction(rejectAction)
        present(messageAlert, animated: true, completion: nil)
    }
    
    func approveAlertMethod(alert: Alert, typeFormID: Int, typeApproveID: Int, observation: String) {
        let approveAlert = approveAlertSending(alert: alert, typeFormID: typeFormID, typeApproveID: typeApproveID, observation: observation)
        let output = json(from:approveAlert as Any)
        //print (output as Any)
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Procesando"
        APIManager.approveAlert(generateApproveSending(json: output ?? ""), success: { (responseApprove: ApproveAlert) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if responseApprove.esValido == 1 {
                self.loadData()
            }
            else{
                    MBProgressHUD.hide(for: self.view, animated: true)
                AlertManager.showAlert(from: self, title: "AppBoa", message: responseApprove.descripcion ?? "", buttonStyle: .default)
            }
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
    
    func approveAlertSending(alert: Alert, typeFormID: Int, typeApproveID: Int, observation: String) -> [String: Any] {
        var body: [String: Any] = [:]
        body["idAlerta"] = alert.alertaIDApprove
        body["sistemaID"] = alert.sistemaId
        body["empleadoID"] = alert.usRemitente
        body["empleadoIDAprobador"] = alert.usDestinatario
        body["tipoAprobacion"] = typeApproveID
        body["tipoFormulario"] = typeFormID
        body["observacion"] = observation
        body["Ip"] = "0.0.0.0"
        body["Titulo"] = "null"
        body["DescripcionCorta"] = "null"
        body["DescripcionCortaLarga"] = "null"
        return body
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func generateApproveSending(json: String) -> [String: Any] {
        var body: [String: Any] = [:]
        body["credenciales"] = ""
        body["dato"] = json

        return body
    }

}
