//
//  JSONResponseDecoder.swift
//  ImageFeedApplication
//
//  Created by Moumita Biswas on 06/12/20.
//

import Foundation

class JSONResponseDecoder {
    
    typealias JSONDecoderCompletionBlock<T> = (T?, Error?) -> Void
    
    static func decodeFrom<T: Decodable>(_ resonseData: Data, expectedModel: T.Type, completionHandler: JSONDecoderCompletionBlock<T>) {
        do {
            let model = try JSONDecoder().decode(expectedModel, from: resonseData)
            completionHandler(model, nil)
        } catch let DecodingError.dataCorrupted(context){
           completionHandler(nil, DecodingError.dataCorrupted(context))
        } catch let DecodingError.valueNotFound(value, context) {
            completionHandler(nil, DecodingError.valueNotFound(value, context))
        } catch let DecodingError.typeMismatch(type, context) {
            completionHandler(nil, DecodingError.typeMismatch(type, context))
        }catch {
           completionHandler(nil,error)
        }
    }
}
