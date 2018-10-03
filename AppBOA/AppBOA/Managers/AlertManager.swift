//
//  AlertManager.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 27/9/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class AlertManager {
    static func showAlert(from viewController: UIViewController, title: String, message: String, buttonStyle: UIAlertActionStyle, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: buttonStyle, handler: handler))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(from viewController: UIViewController, title: String, message: String, buttonStyle: UIAlertActionStyle, buttonTitle: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: buttonStyle, handler: handler))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(from viewController: UIViewController, title: String, message: String, button1Style: UIAlertActionStyle, button1Title: String, button2Style: UIAlertActionStyle, button2Title: String, handler1: ((UIAlertAction) -> Swift.Void)? = nil, handler2: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button1Title, style: button1Style, handler: handler1))
        alert.addAction(UIAlertAction(title: button2Title, style: button2Style, handler: handler2))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func show(from viewController: UIViewController,
                     title: String,
                     message: String,
                     positiveAction: String,
                     negativeAction: String,
                     positiveHandler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: positiveAction, style: .default, handler: positiveHandler))
        alert.addAction(UIAlertAction(title: negativeAction, style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func show(from viewController: UIViewController,
                     title: String,
                     message: String,
                     positiveHandler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: positiveHandler))
        viewController.present(alert, animated: true, completion: nil)
    }
}

