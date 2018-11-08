//
//  AlertDetailsViewController.swift
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

class AlertDetailsViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var originTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var readLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var requestInfo: UILabel!
    
    var selectedAlert: Alert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    fileprivate func loadData() {
        title = "Detalle de la Alerta"
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Procesando"
        //llamada al servicio Lectura Alerta
        APIManager.ReadAlert(generateSendingLectura(), success: { (readAlertResult: ReadAlert) in
            MBProgressHUD.hide(for: self.view, animated: true)
            //let codigo = readAlertResult.codigo;
            
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
        //llamada al servicio para obtener los datos de la alerta
        APIManager.getAlertDetail(generateSending(), success: { (alertDetails: AlertDetails) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.dateLabel.text = alertDetails.fecha
            self.originTitleLabel.text = alertDetails.sistemaOrigen
            self.titleLabel.text = alertDetails.titulo
            self.stateLabel.text = alertDetails.estadoAlerta
            self.readLabel.text = alertDetails.fechaLeido
            var strDescripcion = alertDetails.descripcionCorta
            strDescripcion = strDescripcion?.replacingOccurrences(of: "<br>", with: "\n")
            self.descriptionLabel.text = strDescripcion
            var strDescripcionLarga = alertDetails.descripcion
            strDescripcionLarga = strDescripcionLarga?.replacingOccurrences(of: "<br>", with: "\n")
            self.requestInfo.text = strDescripcionLarga
            
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
        body["alertaID"] = selectedAlert?.alertaID
        body["empleadoId"] = selectedAlert?.empleadoID
        let itemID = UserDefaults.standard.string(forKey: "itemIDSession")
        body["itemId"] = itemID
        return body
    }
    
    func generateSendingLectura() -> [String: Any] {
        var body: [String: Any] = [:]
        body["alertaID"] = selectedAlert?.alertaID
        let usuario = UserDefaults.standard.string(forKey: "userSession")
        body["usuario"] = usuario
        return body
    }
    
    @IBAction func finalizeAlert(_ sender: Any) {
        showConfirmMessage(title: "", message: "Al finalizar la alerta desaparecera de la vista, esta seguro de continuar?", alertID: selectedAlert?.alertaID ?? 0, employeeID: selectedAlert?.empleadoID ?? 0)
    }
    
    func showConfirmMessage(title: String, message: String, alertID: Int, employeeID: Int) {
        let messageAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let approveAction = UIAlertAction(title: "Aceptar", style: .default) { (action) in
            self.finalizeAlertMethod(alertID: alertID, employeeID: employeeID)
        }
        let rejectAction = UIAlertAction(title: "Cancelar", style: .default, handler: {(action) in
            self.loadData()
        })
        messageAlert.addAction(approveAction)
        messageAlert.addAction(rejectAction)
        present(messageAlert, animated: true, completion: nil)
    }
    
    func finalizeAlertMethod(alertID: Int, employeeID: Int) {
        let finAlert = finalizeAlertSending(alertID: alertID, employeeID: employeeID)
        let output = json(from:finAlert as Any)
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Procesando"
        APIManager.finalizeAlert(generateFinalizeAlertSending(json: output ?? ""), success: { (responseFinalizeAlert: FinalizeAlert) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if responseFinalizeAlert.esValido == 1 {
                self.navigationController?.popToRootViewController(animated: true)
            }
            else{
                AlertManager.showAlert(from: self, title: "AppBoa", message: responseFinalizeAlert.descripcion ?? "", buttonStyle: .default)
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
    
    func finalizeAlertSending(alertID: Int, employeeID: Int) -> [String: Any] {
        var body: [String: Any] = [:]
        body["AlertaId"] = alertID
        body["EmpleadoId"] = employeeID
        body["EsItem"] = "False"
        body["ItemId"] = "0"
        return body
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
     func generateFinalizeAlertSending(json: String) -> [String: Any] {
        var body: [String: Any] = [:]
        body["credenciales"] = ""
        body["dato"] = json

        return body
    }
    
}
