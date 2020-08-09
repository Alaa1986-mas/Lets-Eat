//
//  LocationItem.swift
//  LetsEat
//
//  Created by עלאא דאהר on 07/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation

struct LocationItem {
    var city: String?
    var state: String?
    
}

extension LocationItem {
    init(dic: [String:AnyObject]) {
        self.city = dic["city"] as? String
        self.state = dic["state"] as? String
    }
    
    var full: String {
        guard let city = self.city, let state = self.state else {
           return ""
        }
        
        return "\(city), \(state)"
    }
}
