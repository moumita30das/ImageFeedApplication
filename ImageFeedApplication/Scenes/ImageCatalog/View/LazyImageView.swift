//
//  LazyImageView.swift
//  ImageFeedApplication
//
//  Created by Moumita Biswas on 07/12/20.
//

import Foundation
import UIKit

class LazyImageView: UIImageView {
    private let imageCache = NSCache<AnyObject,UIImage>()
    func loadImageFromURL(imageURL:String?, placeHolderImage: String) {
        
      self.image = UIImage(named: placeHolderImage)
        guard let url = imageURL,let imagePath = URL(string:url) else {
            return
        }
        if let cachedImage = imageCache.object(forKey: imagePath as AnyObject) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            [weak self] in
            if let imageData = try? Data(contentsOf: imagePath){
                if let image = UIImage(data: imageData){
                    DispatchQueue.main.async {
                        self?.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
