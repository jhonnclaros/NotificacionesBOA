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


class HomeViewController: UIViewController {
    
    @IBOutlet weak var receiveView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*self.title = "Inicio jhonn2222"
        let alert = UIAlertController(title: "AppBoA", message: "holasss", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
        //self.title = "Inicio jhonn"*/
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func setupUI() {
        title = "Inicio"
        //self.title = "Inicio jhonn"
        //--prueba de llamada servicio
        /*Alamofire.request("http://sms.obairlines.bo/BoAServiceItinerario/servAlerta.svc/GetAlertasAgrupadas",
            method: .post,
            parameters: ["credenciales":"", "empleadoID":"277"],
            encoding: JSONEncoding.default).response { response in
                //Aquí ya podremos trabajar con los datos de la respuesta
                
                let alert = UIAlertController(title: "AppBoA", message: "holasss", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
                //print(response.request as Any)
        }*/
        
        APIManager.getListAlerts(username: "jhonn.claros", success: { () in
            MBProgressHUD.hide(for: self.view, animated: true)
            //UserDefaults.standard.setValue(self.usernameTextField.text!, forKey: "username")
            //UserDefaults.standard.setValue(self.codeTextField.text!, forKey: "accessCode")
            AppDelegate.getDelegate().segueToHomeViewController()
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
