//
//  PhotosCollectionViewCell.swift
//  UsersAndPhotos
//
//  Created by Александр Жуков on 25.11.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        let labelFrame = CGRect(x: 10, y: frame.width, width: (frame.width - 20), height: 80)
        imageView = UIImageView(frame: imageFrame)
        label = UILabel(frame: labelFrame)

        label.numberOfLines = 0
        
        self.contentView.backgroundColor = .systemBackground
        
        self.contentView.layer.cornerRadius = 6
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 0)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath

        self.contentView.addSubview(imageView)
        self.contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
