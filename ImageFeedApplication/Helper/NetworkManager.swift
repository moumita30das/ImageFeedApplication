//
//  NetworkManager.swift
//  ImageFeedApplication
//
//  Created by Moumita Biswas on 05/12/20.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case noData
    case unknown
}

typealias serviceCompletion = (Result<Data,Error>) -> Void

struct NetworkManager {
    
    @discardableResult public static func request(url: String?, completetion: @escaping serviceCompletion) -> URLSessionDataTask? {
        
        guard let apiURL = url,let requestURL =  URL( string: apiURL) else {
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            
            guard let responseData = data, error == nil else {
                completetion(.failure(error ?? NetworkError.unknown))
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, ![200,201].contains(httpStatus.statusCode) {
                completetion(.failure(error ?? NetworkError.invalidResponse))
            }
            
            completetion(.success(responseData))
            
        }
        task.resume()
        return task
    }
}
