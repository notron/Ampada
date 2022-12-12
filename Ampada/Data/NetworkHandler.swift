//
//  NetworkHandler.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation
import Alamofire

class NetworkHandler {
    
    var token : String = ""
    
    init() {}
    
    func sendGetRequest(url: String, parameters: [String: Any], completion: @escaping(Any, Error?) -> Void) {
        
        sendRequest(url: url, method: .get, headers: nil, parameters: parameters, completion: completion)
    }
    
    func sendPostRequest(url: String, parameters: [String: Any], completion: @escaping(Any, Error?) -> Void) {
        
        sendRequestWithEncoding(url: url, method: .post, headers: nil, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func sendPutRequest(url: String, parameters: [String: Any], completion: @escaping(Any, Error?) -> Void) {
        
        sendRequestWithEncoding(url: url, method: .put, headers: nil, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func sendDeleteRequest(url: String, parameters: [String: Any], completion: @escaping(Any, Error?) -> Void) {
        
        sendRequest(url: url, method: .delete, headers: nil, parameters: parameters, completion: completion)
    }
    
    private func sendRequest(url: String, method: HTTPMethod, headers: HTTPHeaders?, parameters: Parameters, completion: @escaping(Any, Error?) -> Void) {
        
        var currentHeaders : HTTPHeaders = [
            "Authorization" : token,
            "Content-Type"  : "application/json"
        ]
        if headers != nil { currentHeaders = headers! }
        
        print("🟨🟨🟨🟨🟨 Send \(method.rawValue) Request : \(url)")
        print("parameters : \(parameters)")
        print("Headers : \(currentHeaders)")
        
        AF.request(url, method: method, parameters: parameters, headers: currentHeaders)
            .responseData { response in
                print("Body For \(url): \n \(String(describing: response.value?.convertToDictionary()))")
                
            switch response.result {
            case .success:
                
                do {
                    let errorDTO = try JSONDecoder().decode(ErrorDTO.self, from: response.value ?? Data())
                    
                    completion(false, errorDTO.toError())

                } catch {
                    print("getDataList Unexpected error: \(error).")
                    completion(response.value as Any, nil)
                }
                
                //completion(response.value as Any, true)
            case .failure(let error):
                completion(false, Error(error.errorDescription ?? ""))
            }
        }
    }
    
    private func sendRequestWithEncoding(url: String, method: HTTPMethod, headers: HTTPHeaders?, parameters: Parameters, encoding: ParameterEncoding, completion: @escaping(Any, Error?) -> Void) {
        
        var currentHeaders : HTTPHeaders = [
            "Authorization"   : "Bearer " + token,
            "Content-Type" : "application/json"
        ]
        if headers != nil { currentHeaders = headers! }
        
        print("🟨🟨🟨🟨🟨 Send \(method.rawValue) Request : \(url)")
        print("parameters : \(parameters)")
        print("Headers : \(currentHeaders)")
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: currentHeaders)
            .responseData { response in
                print("Body For \(url): \n \(String(describing: response.value?.convertToDictionary()))")
            switch response.result {
            case .success:
                completion(response.value as Any, nil)
            case .failure(let error):
                completion(false, Error(error.errorDescription ?? ""))
            }
        }
    }
}
