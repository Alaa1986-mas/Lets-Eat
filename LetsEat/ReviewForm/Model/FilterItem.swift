//
//  FilterItem.swift
//  LetsEat
//
//  Created by עלאא דאהר on 14/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation


class FilterItem: NSObject {
    var name: String
    var filter: String
    
    init(dic: [String:AnyObject]) {
        self.name = dic["name"] as! String
        self.filter = dic["filter"] as! String
     }
}
