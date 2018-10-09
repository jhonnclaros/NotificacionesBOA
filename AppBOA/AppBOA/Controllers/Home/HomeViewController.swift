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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func setupUI() {
        title = "Inicio"
        APIManager.getListAlerts(username: "jhonn.claros", success: { (alerts: [Alert]) in
            MBProgressHUD.hide(for: self.view, animated: true)
            //UserDefaults.standard.setValue(self.usernameTextField.text!, forKey: "username")
            //UserDefaults.standard.setValue(self.codeTextField.text!, forKey: "accessCode")
            //AppDelegate.getDelegate().segueToHomeViewController()
            
            
        }, failure: { (error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            var errorMessage = Constants.Error.InternalServerMessage
            var titleMessage = Constants.Error.ErrorInternalServerTitle
            if error != nil {
                errorMessage = (error?.desc)!
                titleMessage = "ScanIt"
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
    
}
