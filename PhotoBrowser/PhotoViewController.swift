//
//  PhotoViewController.swift
//  PhotoBrowser
//
//  Created by Anna Nguyen on 10/13/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photo: Photo?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageService.shared.imageForURL(url: photo?.url) { (image, URL) in
            self.imageView.image = image
        }
        
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowserCell", for: indexPath) as! BrowserCell
        cell.configure(photo: photo!)
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        photoViewController.photo = photo!
        present(photoViewController, animated: true, completion: nil)
    }
}
