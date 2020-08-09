//
//  PhotoCell.swift
//  LetsEat
//
//  Created by עלאא דאהר on 22/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  
    @IBOutlet weak var imageView: UIImageView!
    
    func roundedImage() {
        imageView.layer.cornerRadius = 20.0
        imageView.layer.masksToBounds = true
    }
}
