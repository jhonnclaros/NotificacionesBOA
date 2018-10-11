//
//  APIManager.swift
//  AppBOA
//
//  Created by Boa Desarrollo Sistemas on 26/9/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RealmSwift

class APIManager {
    
    /*fileprivate static var binsEndpoint: String? {
        return Constants.API.BaseServer + (DBManager.shared.getConfig()?.endpoints?.bins)!
    }
    
    fileprivate static var getPOEndpoint: String? {
        var url = URL(string: Constants.API.BaseServer)
        url = url?.appendingPathComponent((DBManager.shared.getConfig()?.endpoints?.unreceived)!)
        return (url?.absoluteString)!
    }*/
    
    fileprivate static var getAlertListEndpoint: String? {
        return Constants.API.ServiceBaseServer + "/GetAlertasAgrupadas"
    }
    
    fileprivate static var getApproveAlertListEndpoint: String? {
        return Constants.API.ServiceBaseServer + "/GetAlertas"
    }

    static func getListAlerts(username: String, success:@escaping (_ alerts: [Alert]) -> (), failure:@escaping (_ error: ServerError?) -> ()) {
        if !ReachabilityManager.shared.isNetworkAvailable {
            failure(ServerError(error: ["desc": Constants.Error.InternetConnectionError]))
            return
        }
        //let headers = createAuthorizationHeaders(user: username, password: password)
        //let baseURL = Constants.API.ServiceBaseServer + "/GetAlertasAgrupadas"
        let parameters: Parameters = [ "credenciales": "", "empleadoID": "1"]
        
        Alamofire.request(getAlertListEndpoint!, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseObject { (response: DataResponse<Lista>) in
                if response.error == nil {
                    let alerts = response.result.value
                    success(alerts!.lista)
                }
                else{
                    failure(nil)
                }
        }
    }
    
    static func getApproveAlertList(_ data: [String: Any], success:@escaping (_ alerts: [Alert]) -> (), failure:@escaping (_ error: ServerError?) -> ()) {
        if !ReachabilityManager.shared.isNetworkAvailable {
            failure(ServerError(error: ["desc": Constants.Error.InternetConnectionError]))
            return
        }
        
        let parameters: Parameters = [
            "credenciales": "",
            "idSistema": "26",
            "filtro": "",
            "empleadoID": "1",
            "estado": "0",
            "pagina": "1",
            "fechaIni": "",
            "fechaFin": "",
            "busquedaHistorialint": "0",
            "paginacion_size": "1000",
            "tipoAlerta": "2",
            "Tipo": "1"
        ]
        
        Alamofire.request(getApproveAlertListEndpoint!, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseObject { (response: DataResponse<AlertList>) in
                if response.error == nil {
                    let alerts = response.result.value
                    success(alerts!.lista)
                }
                else{
                    failure(nil)
                }
        }
    }
    
    /*static func login(username: String, password: String, code: String, success:@escaping () -> (), failure:@escaping (_ error: ServerError?) -> ()) {
        if !ReachabilityManager.shared.isNetworkAvailable {
            failure(ServerError(error: ["desc": Constants.Error.InternetConnectionError]))
            return
        }
        let headers = createAuthorizationHeaders(user: username, password: password)
        if code == "apple" {
            UserDefaults.standard.set("https://72ptcibcq7.execute-api.us-west-2.amazonaws.com/apple", forKey: "BaseURLApple")
        }
        else {
            UserDefaults.standard.removeObject(forKey: "BaseURLApple")
        }
        Alamofire.request(Constants.API.AuthorizationURL(accessCode: code), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseObject { (response: DataResponse<Config>) in
                if response.error != nil {
                    if let res = response.response, (400..<599).contains(res.statusCode) { //to display error 504, incorrect username and/or password
                        //                        if (400..<499).contains(response.response!.statusCode) { //Business rule
                        var errorsList: List<ServerError> = List<ServerError>()
                        if let data = response.data {
                            if let json = try? JSONSerialization.jsonObject(with: data,  options: []) as! [[String : Any]] {
                                errorsList = getErrorList(errors: json.reversed())
                            }
                        }
                        for error in errorsList {
                            failure(error)
                        }
                    } else {
                        failure(nil)
                    }
                }
                else {
                    UserDefaults.standard.set(headers, forKey: "AuthorizationHeaders")
                    let config = response.result.value
                    DBManager.shared.saveConfig(config!)
                    if (config?.locations.isEmpty)! {
                        self.getLocations(success: { (locations) in
                            DBManager.shared.appendLocations(locations: locations, config: config!)
                            success()
                        }, failure: { (error) in
                            success()
                        })
                    }
                    else {
                        success()
                    }
                }
        }
    }*/

    struct JSONArrayEncoding: ParameterEncoding {
        private let array: [AnyObject]
        init(array: [AnyObject]) {
            self.array = array
        }
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var urlRequest = try urlRequest.asURLRequest()
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            urlRequest.httpBody = data
            return urlRequest
        }
    }
}

