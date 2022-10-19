//
//  Common.swift
//  Coding Assignment
//
//  Created by RAHUL SINGHA ROY on 18/10/22.
//

import Foundation

struct HttpUtility {
    /// Common API call function
    /// - Parameters:
    ///   - requestUrl: API URL
    ///   - requestType: JSON Decode Data Type
    ///   - complitionHandler: Data Complition Handler
    func getApiData<T: Codable>(requestUrl: URL, requestType: T.Type, complitionHandler:@escaping(_ result: T)-> Void) {
        let request = URLRequest(url: requestUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
                if let data = data, let body = String(data: data, encoding: .utf8) {
                    let jsonData = body.data(using: .utf8)!
                    let decoder = JSONDecoder()
                    print(body)
                    do {
                        let structModelData = try decoder.decode(T.self, from: jsonData)
                        _ = complitionHandler(structModelData)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } else {
                print(error ?? "API Error")
            }
        }
        task.resume()
    }
}
