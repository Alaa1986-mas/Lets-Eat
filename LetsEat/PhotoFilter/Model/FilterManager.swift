//
//  FilterManager.swift
//  LetsEat
//
//  Created by עלאא דאהר on 14/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation

class FilterManger: DataManger {
    
    func fetch(completionHandler: (_ items: [FilterItem]) -> Swift.Void) {
        
        var items: [FilterItem] = []
        
        for data in load("FilterData") {
            items.append(FilterItem(dic: data))
        }
        
        completionHandler(items)
        
    }
    
}
