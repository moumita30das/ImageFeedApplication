//
//  ImageTableViewCell.swift
//  ImageFeedApplication
//
//  Created by Moumita Biswas on 07/12/20.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var imageview: LazyImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func updateCell(imageInfo:Image) {
        labelAuthor.text = imageInfo.author
        var imageURL:String? = nil
        if let imageId = imageInfo.imageId {
            imageURL = APIPath.imagePath.rawValue + String(imageId)
        }
        self.imageview.loadImageFromURL(imageURL: imageURL, placeHolderImage: "placeholder")
    }
}
