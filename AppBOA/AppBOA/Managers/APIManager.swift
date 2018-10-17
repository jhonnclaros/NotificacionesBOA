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
    
    fileprivate static var getAlertDetailsEndpoint: String? {
        return Constants.API.ServiceBaseServer + "/GetDetalleAlerta"
    }
    
    fileprivate static var getApproveAlertEndpoint: String? {
        return Constants.API.ServiceBaseServer + "/AprobarAlert"
    }
    
    fileprivate static var loginEndpoint: String? {
        return Constants.API.ServiceBaseServerProof + "/AutentificarUsuario"
    }
    
    fileprivate static var userInfoEndpoint: String? {
        return Constants.API.ServiceBaseServerProof + "/GetUserInfo"
    }

    static func getListAlerts(empleadoID: String, success:@escaping (_ alerts: [Alert]) -> (), failure:@escaping (_ error: ServerError?) -> ()) {
        if !ReachabilityManager.shared.isNetworkAvailable {
            failure(ServerError(error: ["desc": Constants.Error.InternetConnectionError]))
            return
        }

        let parameters: Parameters = [ "credenciales": "", "empleadoID": empleadoID]
        
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

        Alamofire.request(getApproveAlertListEndpoint!, method: .post, parameters: data, encoding: JSONEncoding.default)
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
    
    static func approveAlert(_ data: [String: Any], success:@escaping (_ result: ApproveAlert) -> (), failure:@escaping (_ error: ServerError?) -> ()) {
        if !ReachabilityManager.shared.isNetworkAvailable {
            failure(ServerError(error: ["desc": Constants.Error.InternetConnectionError]))
            return
        }
        
        Alamofire.request(getApproveAlertEndpoint!, method: .post, parameters: data, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseObject { (response: DataResponse<ApproveAlert>) in
                if response.error == nil {
                    let resultApprove = response.result.value
                    success(resultApprove!)
                }
                else{
                    failure(nil)
                }
        }
    }
    
    static func getAlertDetail(_ data: [String: Any], success:@escaping (_ alertDetails: AlertDetails) -> (), failure:@escaping (_ error: ServerError?) -> ()) {
        if !ReachabilityManager.shared.isNetworkAvailable {
            failure(ServerError(error: ["desc": Constants.Error.InternetConnectionError]))
            return
        }
        
        Alamofire.request(getAlertDetailsEndpoint!, method: .post, parameters: data, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseObject { (response: DataResponse<AlertDetails>) in
                if response.error == nil {
                    let alertdetails = response.result.value
                    success(alertdetails!)
                }
                else{
                    failure(nil)
                }
        }
    }
    
    static func login(username: String, password: String, success:@escaping (_ loginData: Login) -> (), failure:@escaping (_ error: ServerError?) -> ()) {
        if !ReachabilityManager.shared.isNetworkAvailable {
            failure(ServerError(error: ["desc": Constants.Error.InternetConnectionError]))
            return
        }
        let parameters: Parameters = [ "username": username, "pwd": password]
        
        Alamofire.request(loginEndpoint!, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseObject { (response: DataResponse<Login>) in
                
                if response.error == nil {
                    let loginInfo = response.result.value
                    success(loginInfo!)
                }
                else{
                    failure(nil)
                }
        }
    }
    
    static func userInfo(username: String, success:@escaping (_ userInfo: UserInfo) -> (), failure:@escaping (_ error: ServerError?) -> ()) {
        if !ReachabilityManager.shared.isNetworkAvailable {
            failure(ServerError(error: ["desc": Constants.Error.InternetConnectionError]))
            return
        }
        let parameters: Parameters = [ "username": username]
        
        Alamofire.request(userInfoEndpoint!, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseObject { (response: DataResponse<UserInfo>) in
                
                if response.error == nil {
                    let userInfo = response.result.value
                    success(userInfo!)
                }
                else{
                    failure(nil)
                }
        }
    }
    
    static func getErrorList(errors: [[String : Any]]) -> [ServerError] {
        var errorsList: [ServerError] = []
        for error in errors {
            if error["description"] != nil {
                errorsList.append(ServerError(error: error))
            }
        }
        return errorsList
    }

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

