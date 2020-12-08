//
//  ImageFeedPresenter.swift
//  ImageFeedApplication
//
//  Created by Moumita Biswas on 06/12/20.
//

import Foundation
protocol ImageListPresenter {
    func decodedImageListToDisplay(imageList: [Image])
}

class ImageFeedPresenter: ImageListPresenter {
    
    var viewController:DisplayImageFromPresenter? = nil
    func decodedImageListToDisplay(imageList: [Image]) {
        viewController?.displayImage(imageList: imageList)        
    }
}
