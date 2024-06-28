//
//  NetworkUtility.swift
//  Weather App
//
//  Created by Nuveda on 24/06/24.
//

import Foundation

class NetworkUtility {
    func fetchData(url: String, parameters: [String: String], completion: @escaping (Data?) -> Void) {
        guard var urlComponents = URLComponents(string: url) else {
            completion(nil)
            return
        }
        
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let finalURL = urlComponents.url else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: finalURL) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
        
        task.resume()
    }
}
