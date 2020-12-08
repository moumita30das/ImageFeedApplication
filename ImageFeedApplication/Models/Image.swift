//
//  Image.swift
//  ImageFeedApplication
//
//  Created by Moumita Biswas on 06/12/20.
//

import Foundation


struct AllImages:Decodable {
    let imageList:[Image]
}

struct Image {
    var imageId:Int? 
    let author:String?
}

extension Image:Decodable {
    enum CodingKeys: String,CodingKey {
      case imageId = "id"
      case author
    }
}

