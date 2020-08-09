//
//  FilterCell.swift
//  LetsEat
//
//  Created by עלאא דאהר on 15/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
 
    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgThumb: UIImageView!
    
}


extension FilterCell: ImageFiltering {
    
    func set(image: UIImage, item: FilterItem) {
        
        if item.name != "None" {
            
            let filteredImage = apply(filter: item.filter, orginalImage: image)
            
            imgThumb.image = filteredImage
            
        } else {
            imgThumb.image = image
        }
        
        lblName.text = item.name
        roundedCorners()
    }
    
    func roundedCorners() {
        imgThumb.layer.cornerRadius = 9.0
        imgThumb.layer.masksToBounds = true
    }
    
}
