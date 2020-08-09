//
//  ReviewDataManager.swift
//  LetsEat
//
//  Created by עלאא דאהר on 21/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit

class ReviewDataManager: NSObject {

    private var reviewItems: [ReviewItem] = []
    private var photoItems: [ResturantPhotoItem] = []
    
    let manager = CoreDataManager()
    
    func fetchReview(by resturantId: Int) {
       
        if reviewItems.count > 0 { reviewItems.removeAll() }
        
        
        for data in manager.fetchReviews(by: resturantId) {
            reviewItems.append(data)
        }
        
    }
    
    func fetchPhoto(by resturantId: Int) {
        
        if photoItems.count > 0 { photoItems.removeAll() }
        
        for data in manager.fetchPhotos(by: resturantId) {
            photoItems.append(data)
        }
        
    }
    
    func numberOfReviews() -> Int {
        return reviewItems.count
    }
    
    func numberOfPhotos() -> Int {
        return photoItems.count
    }
    
    func reviewItem(at indexPath: IndexPath) -> ReviewItem {
        return reviewItems[indexPath.item]
    }
    
    func photoItem(at indexPath: IndexPath) -> ResturantPhotoItem {
        return photoItems[indexPath.item]
    }
    
}
