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
            APIManager.login(username: usernameTextField.text!, password: passwordTextField.text!,  success: { (loginData: Login) in
                //MBProgressHUD.hide(for: self.view, animated: true)
                if loginData.codigo == 1 {
                    //AppDelegate.getDelegate().segueToHomeViewController()
                    //llamar al servicio userinfo
                    APIManager.userInfo(username: self.usernameTextField.text!, success: { (userInfo: UserInfo) in
                        MBProgressHUD.hide(for: self.view, animated: true)
                        if userInfo.employeeID > 0 {
                            AppDelegate.getDelegate().segueToHomeViewController()

                            UserDefaults.standard.setValue(userInfo.userName, forKey: "userSession")
                            UserDefaults.standard.setValue(userInfo.employeeID, forKey: "employeeIDSession")
                            UserDefaults.standard.setValue(userInfo.employeeName, forKey: "employeeNameSession")
                            UserDefaults.standard.setValue(userInfo.itemID, forKey: "itemIDSession")
                        }
                        else{
                            MBProgressHUD.hide(for: self.view, animated: true)
                            AlertManager.showAlert(from: self, title: "AppBoa", message: "Usuario Incorrecto", buttonStyle: .default)
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
                    
                    
                    UserDefaults.standard.setValue(self.usernameTextField.text, forKey: "userSession")
                }
                else{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    AlertManager.showAlert(from: self, title: "AppBoa", message: "Usuario Incorrecto", buttonStyle: .default)
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
    }
    
    @IBAction func showPassword(_ sender: UISwitch) {
        if sender.isOn {
            self.passwordTextField.isSecureTextEntry = false
        }
        else {
            self.passwordTextField.isSecureTextEntry = true
        }
    }
    
    
}

