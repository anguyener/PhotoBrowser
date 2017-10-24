//
//  BrowserCell.swift
//  PhotoBrowser
//
//  Created by Anna Nguyen on 10/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class BrowserCell: UICollectionViewCell {
    
    var photo: Photo?
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(photo: Photo) {
        self.photo = photo
        nameLabel.text = photo.title
        ImageService.shared.imageForURL(url: photo.url){ (image, url) in 
           if url == self.photo?.url {
                self.imageView.image = image
            } 
        }
    }
    
}

