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
        hud.label.text = "Processing"
        APIManager.getAlertDetail(generateSending(), success: { (alertDetails: AlertDetails) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.dateLabel.text = alertDetails.fecha
            self.originTitleLabel.text = alertDetails.sistemaOrigen
            self.titleLabel.text = alertDetails.titulo
            self.stateLabel.text = alertDetails.estadoAlerta
            self.readLabel.text = alertDetails.fechaLeido
            self.descriptionLabel.text = alertDetails.descripcionCorta
            self.requestInfo.text = alertDetails.descripcion
            
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
        body["itemId"] = "18260"
        return body
    }
}
