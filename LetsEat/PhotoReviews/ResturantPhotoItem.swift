//
//  ResturantPhotoItem.swift
//  LetsEat
//
//  Created by עלאא דאהר on 17/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation
import UIKit

struct ResturantPhotoItem {
    var resturantId: Int?
    var photo: UIImage?
    var date: Date?
    var uuid = UUID().uuidString
    
    var photoData: NSData {
        guard let image = photo else {
            return NSData()
        }
        
        return NSData(data: image.pngData()!)
    }
}

extension ResturantPhotoItem {
    
    init(data: ResturantPhoto) {
        self.resturantId = Int(data.resturantId)
        
        if let resturantPhoto = data.photo {
            self.photo = UIImage(data: resturantPhoto, scale: 1.0)
        }
        
        if let photoDate = data.date {
            self.date = photoDate
        }
        
        if let uuid = data.uuid {
            self.uuid = uuid
        }
    }
}
