//
//  HomeViewController.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 25/9/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import Alamofire
import AlamofireObjectMapper
import Reachability


class HomeViewController: UITableViewController {
    
    @IBOutlet weak var receiveView: UIView!
    @IBOutlet var tableViewAlerts: UITableView!
    var alerts = [Alert]()
    var selectedAlert: Alert?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func loadData() {
        title = "Alertas"
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Procesando"
        let employeeID = UserDefaults.standard.string(forKey: "employeeIDSession")
        APIManager.getListAlerts(empleadoID: employeeID ?? "0", success: { (alerts: [Alert]) in
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
    
    /*@IBAction func menuAction(_ sender: UIBarButtonItem) {
        AppDelegate.getDelegate().presentMenuViewController(controller: self)
    }*/
    
    @IBAction func countAction(_ sender: UIButton) {
        performSegue(withIdentifier: "CountSegue", sender: nil)
    }
    
    @IBAction func receiveAction(_ sender: UIButton) {
        performSegue(withIdentifier: "ReceiveSegue", sender: nil)
    }
    
    @IBAction func menuAction(_ sender: Any) {
        AppDelegate.getDelegate().segueToMenuViewController()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertCell", for: indexPath) as! AlertTableViewCell
        
        let tituloAlerta: String = alerts[indexPath.row].titulo ?? ""
        let fechaAlerta: String = alerts[indexPath.row].fecha ?? ""
        cell.titleAlertNameLabel.text = tituloAlerta
        cell.accessoryType = .disclosureIndicator
        if alerts[indexPath.row].alertaID > 0 {
            cell.accessoryType = .detailDisclosureButton
            cell.titleAlertNameLabel.text = fechaAlerta + " - " + tituloAlerta
        }
        cell.typeAlertNameLabel.text = alerts[indexPath.row].sistemaOrigen
        cell.descriptionAlertNameLabel.text = alerts[indexPath.row].descripcionCorta
            
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedAlert = alerts[indexPath.row]
        if alerts[indexPath.row].alertaID > 0 {
            performSegue(withIdentifier: "detailAlertSegue", sender: nil)
        }
        else {
            performSegue(withIdentifier: "approveAlertsSegue", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailAlertSegue" {
            let detailsVC = segue.destination as? AlertDetailsViewController
            detailsVC?.selectedAlert = self.selectedAlert
        }
        else if segue.identifier == "approveAlertsSegue" {
            let detailsVC = segue.destination as? ApproveAlertTableViewController
            detailsVC?.selectedAlert = self.selectedAlert
        }
    }
    
}
