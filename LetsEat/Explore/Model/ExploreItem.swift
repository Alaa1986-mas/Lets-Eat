//
//  ExploreItem.swift
//  LetsEat
//
//  Created by עלאא דאהר on 28/06/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation


struct ExploreItem {
    var name: String
    var image: String
}

extension ExploreItem {
    init(dic: [String:AnyObject]) {
        self.name = dic["name"] as! String
        self.image = dic["image"] as! String
    }
}
