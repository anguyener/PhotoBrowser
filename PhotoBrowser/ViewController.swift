//
//  ViewController.swift
//  PhotoBrowser
//
//  Created by Anna Nguyen on 10/12/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var photos: [Photo] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchData()
        
    }
    
    func fetchData() {
        let url = URL(string: "https://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=daffodil&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){ (data, response, err) in
            let data = data!
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            let array = json as! [String: Any]
            let arr = array["photos"] as! [String: Any]
            let ar = arr["photo"] as! [[String: Any]]
            self.photos = ar.map{ Photo(dictionary: $0)}
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowserCell", for: indexPath) as! BrowserCell
        cell.configure(photo: photos[indexPath.item])
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let PhotoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        PhotoViewController.photo = photos[indexPath.item]
        present(PhotoViewController, animated: true, completion: nil)
    }
}



