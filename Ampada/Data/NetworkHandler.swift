//
//  NetworkHandler.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation
import Alamofire

final class NetworkHandler {
    
    var token : String = ""
    
    init() {

//        if let accessToken = UserDefaults.standard.string(forKey: Keys.token) {
//            token = "\(accessToken)"
//        }
    }
    
    func sendGetRequest(url: String, parameters: [String: Any], completion: @escaping(Any, Bool) -> Void) {
        
        sendRequest(url: url, method: .get, headers: nil, parameters: parameters, completion: completion)
    }
    
    func sendPostRequest(url: String, parameters: [String: Any], completion: @escaping(Any, Bool) -> Void) {
        
        sendRequestWithEncoding(url: url, method: .post, headers: nil, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func sendPutRequest(url: String, parameters: [String: Any], completion: @escaping(Any, Bool) -> Void) {
        
        sendRequestWithEncoding(url: url, method: .put, headers: nil, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func sendDeleteRequest(url: String, parameters: [String: Any], completion: @escaping(Any, Bool) -> Void) {
        
        sendRequest(url: url, method: .delete, headers: nil, parameters: parameters, completion: completion)
    }
    
    private func sendRequest(url: String, method: HTTPMethod, headers: HTTPHeaders?, parameters: Parameters, completion: @escaping(Any, Bool) -> Void) {
        
        var currentHeaders : HTTPHeaders = [
            "AUTH-TOKEN"    : token,
            "Content-Type"  : "application/json"
        ]
        if headers != nil { currentHeaders = headers! }
        
        print("🟨🟨🟨🟨🟨 Send \(method.rawValue) Request : \(url)")
        print("parameters : \(parameters)")
        print("Headers : \(currentHeaders)")
        
        AF.request(url, method: method, parameters: parameters, headers: currentHeaders)
            .responseData { response in
                print("Body For \(url): \(String(describing: response.value?.convertToDictionary()))")
            switch response.result {
            case .success:
                completion(response.value as Any, true)
            case .failure(let error):
                completion(error, false)
            }
        }
    }
    
    private func sendRequestWithEncoding(url: String, method: HTTPMethod, headers: HTTPHeaders?, parameters: Parameters, encoding: ParameterEncoding, completion: @escaping(Any, Bool) -> Void) {
        
        var currentHeaders : HTTPHeaders = [
            "AUTH-TOKEN"   : token,
            "Content-Type" : "application/json"
        ]
        if headers != nil { currentHeaders = headers! }
        
        print("🟨🟨🟨🟨🟨 Send \(method.rawValue) Request : \(url)")
        print("parameters : \(parameters)")
        print("Headers : \(currentHeaders)")
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: currentHeaders)
            .responseData { response in
                print("Body For \(url): \(String(describing: response.value?.convertToDictionary()))")
            switch response.result {
            case .success:
                completion(response.value as Any, true)
            case .failure(let error):
                completion(error, false)
            }
        }
    }
}
