//
//  ImageFeedInteractor.swift
//  ImageFeedApplication
//
//  Created by Moumita Biswas on 06/12/20.
//

import Foundation

protocol FetchImageListInteractor {
    var imageList:[Image] {get}
    func imageFeedFromServer()
}

class ImageFeedInteractor:FetchImageListInteractor {
    
    var presenter:ImageListPresenter?
    var imageList:[Image] = []
    private var sessionTask:URLSessionDataTask?
    func imageFeedFromServer() {
        
        sessionTask = NetworkRequest().imageListApiRequest(completionHandler: {[weak self] (response) in
            self?.sessionTask = nil
            switch response {
            case .success(let imageList):
                self?.imageList = imageList
                self?.presenter?.decodedImageListToDisplay(imageList:  self!.imageList)
            case .failure(let error):
                 print(error)
            }
            
        })
        
    }
    
}
