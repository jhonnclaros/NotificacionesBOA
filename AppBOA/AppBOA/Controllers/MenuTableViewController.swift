//
//  MenuTableViewController.swift
//  AppBOA
//
//  Created by Danitza on 10/14/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func logout() {
        AppDelegate.getDelegate().logout()
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            logout()
        default:
            break
        }
    }
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

