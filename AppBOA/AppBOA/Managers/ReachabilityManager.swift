//
//  ReachabilityManager.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 26/9/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import UIKit
import Reachability

class ReachabilityManager: NSObject {
    static  let shared = ReachabilityManager()
    let reachability = Reachability()!
    
    var isNetworkAvailable : Bool {
        switch reachability.connection {
        case .none:
            return false
        default:
            return true
        }
    }
    
    func startNotifier() {
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                //Reachable via WiFi
            }
            else {
                //Reachable via Cellular
            }
        }
        reachability.whenUnreachable = { _ in
            //Not reachable
        }
        do {
            try reachability.startNotifier()
        } catch {
            //Unable to start notifier
        }
    }
    
    func stopNotifier() {
        reachability.stopNotifier()
    }
    
}
