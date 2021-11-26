//
//  PhotosViewController.swift
//  UsersAndPhotos
//
//  Created by Александр Жуков on 25.11.2021.
//

import UIKit

class PhotosViewController: UIViewController {
    
    let parser = Parser()
    var photos: Photos?
    var userName = ""
    var userID = 0
    
    private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadPhotos(photosUrl: imagesUrl(userID: userID))
    }
    
    func configureView() {
        self.title = userName
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "item")
        
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        self.view.addSubview(collectionView)
    }
    
    
    func loadPhotos(photosUrl: String) {
        self.parser.parsePhotos(url: photosUrl) { photos in
            guard let photos = photos else { return }
            self.photos = photos
            self.collectionView.reloadData()
        }
    }
    
    @objc func reload(refreshControl: UIRefreshControl) {
        loadPhotos(photosUrl: imagesUrl(userID: userID))
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = (collectionView.frame.width - 20)
        let heightPerItem = (widthPerItem + 80)
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! PhotosCollectionViewCell
        let photo = self.photos![indexPath.row]
        item.imageView.loadImageUsingCache(withUrl: photo.url)
        item.label.text = photo.title
        return item
    }
}


let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }
}
