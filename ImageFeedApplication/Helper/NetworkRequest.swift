//
//  NetworkRequest.swift
//  ImageFeedApplication
//
//  Created by Moumita Biswas on 05/12/20.
//

import Foundation

typealias imageListCompletionBlock = (Result<[Image],Error>) -> Void

protocol ImageFeedProtocol {
   @discardableResult func imageListApiRequest(completionHandler: @escaping imageListCompletionBlock) -> URLSessionDataTask?
}
struct NetworkRequest {
    
    @discardableResult func imageListApiRequest(completionHandler: @escaping imageListCompletionBlock) -> URLSessionDataTask? {
        
        return NetworkManager.request(url: APIPath.imageListApi.rawValue) { response in
            switch response {
            case .success(let data):
                JSONResponseDecoder.decodeFrom(data, expectedModel: [Image].self) { (decodedResponse,error) in
                    
                    if let parseError = error {
                        completionHandler(.failure(parseError))
                        return
                    }
                    
                    if let imageResponse = decodedResponse {
                        completionHandler(.success(imageResponse))
                        return
                    }
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
    func imageFetchApiRequest(imageId: String,completionHandler: @escaping () -> ()){
        
    }
}
