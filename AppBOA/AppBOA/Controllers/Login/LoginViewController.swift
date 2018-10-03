//
//  LoginViewController.swift
//  appBOA
//
//  Created by macmini on 9/21/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import UIKit
import MBProgressHUD
import Reachability

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //-- functions
    fileprivate func fieldsAreValid() -> Bool {
        var isValid = true
        var message = ""
        if (usernameTextField.text?.isEmpty)! {
            message = "Usuario Requerido"
            isValid = false
        }
        else if (passwordTextField.text?.isEmpty)! {
            message = "Contraseña Requerida"
            isValid = false
        }

        if !isValid {
            let alert = UIAlertController(title: "AppBoA", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
        return isValid
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        if fieldsAreValid() {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = "Procesando"
            AppDelegate.getDelegate().segueToHomeViewController()
            UserDefaults.standard.setValue(usernameTextField.text, forKey: "userSession")
        }
    }
    
}

