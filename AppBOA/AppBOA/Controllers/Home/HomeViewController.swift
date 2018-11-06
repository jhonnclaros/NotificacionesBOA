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
    var reloadTimer: Timer!
    //var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTimer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(reloadTableView), userInfo: nil, repeats: true)
        // Refresh control add in tableview.
        //self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //self.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        //self.tableViewAlerts.addSubview(self.refreshControl!)
        
        //self.tableViewAlerts.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        loadData()
    }
    
    @objc func refresh(_ sender: Any) {
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func loadData() {
        title = "Alertas"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
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
    
    @objc func reloadTableView() {
        loadData()
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
        //AppDelegate.getDelegate().segueToMenuViewController()
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MenuTableViewController")
        self.present(vc, animated: true, completion: nil)
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
        var strDescripcion = alerts[indexPath.row].descripcionCorta
        strDescripcion = strDescripcion?.replacingOccurrences(of: "<br>", with: "\n")
        cell.descriptionAlertNameLabel.text = strDescripcion
            
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
