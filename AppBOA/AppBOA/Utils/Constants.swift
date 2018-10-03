//
//  Constants.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 26/9/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import UIKit

enum MeasureType: Int {
    case counting = 1, receiving = 2
}

struct Constants {
    
    static let DefaultHeightView = 44
    
    struct API {
        static var BaseServer: String {
            var baseString = ""
            if let baseURL = UserDefaults.standard.object(forKey: "BaseURLApple") {
                baseString = baseURL as! String
            }
            if let baseURL = UserDefaults.standard.object(forKey: "BaseURL") {
                baseString = baseURL as! String
            }
            if baseString.hasSuffix("/") {
                baseString = String(baseString.dropLast())
            }
            return baseString
        }
        
        static var ServiceBaseServer: String {
            if let baseURL = UserDefaults.standard.object(forKey: "servicesBaseURL") {
                return baseURL as! String
            }
            return "http://sms.obairlines.bo/BoAServiceItinerario/servAlerta.svc"
        }
        
        static func AuthorizationURL(accessCode: String) -> String {
            var url = URL(string: Constants.API.BaseServer)
            url = url?.appendingPathComponent("apis/v0/buyers/\(accessCode)/welcomes/scanit")
            return (url?.absoluteString)!
        }
    }
    
    struct Error {
        static let LoginCredentials = "Username or password incorrect."
        static let InvalidData = "Data is invalid."
        static func NetworkError(service: String) -> String {
            return "Failed to \(service) due to network error.\nPlease try again."
        }
        static let UnableSubmitToServer = "Unable to Submit data to server."
        static let InternetConnectionError = "Please check your internet connection and try again."
        static let InternetConnectionTitle = "Internet connection"
        static let InternalServerMessage = "An unexpected error has ocurred. Please try again."
        static let ErrorInternalServerTitle = "Error internal server"
        static let ServerError = "Server Error"
        static let InvalidServerAddress = "Invalid Server Address, formatting should follow http(s)://address:port/prefixpath"
        static let ErrorExceedsCharacterLimit = "Barcode exceeds system character limit."
    }
    
    struct Eula {
        static let Name = "ScanIt iOS"
        static let Version = "201802"
    }

    struct Strings {
        static let Copyright = "Copyright 2018. Boliviana de Aviación, Inc. \nAll rights reserved."
    }
 
}
