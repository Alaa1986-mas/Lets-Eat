//
//  ReviewItem.swift
//  LetsEat
//
//  Created by עלאא דאהר on 17/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation

struct ReviewItem {
    
    var rating: Float?
    var title: String?
    var name: String?
    var date: Date?
    var customerReview: String?
    var resturantId: Int?
    
    var uuid = UUID().uuidString
    
    
    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        
        guard let reviewDate = date else {
            return ""
        }
        
        return formatter.string(from: reviewDate as Date)
    }
    
}

extension ReviewItem {
    
    init(data: Review) {
        if let reviewDate = data.date {
            self.date = reviewDate
        }
        
        self.customerReview = data.customerReview
        self.title = data.title
        self.name = data.name
        self.resturantId = Int(data.resturantId)
        self.rating = data.rating
        if let uuid = data.uuid {
            self.uuid = uuid
        }
        
    }
}
