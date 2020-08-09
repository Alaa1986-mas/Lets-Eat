//
//  ExploreDataManger.swift
//  LetsEat
//
//  Created by עלאא דאהר on 28/06/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation

class ExploreDataManger: DataManger {
    
    fileprivate var items: [ExploreItem] = []
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func explore(at index: IndexPath) -> ExploreItem {
        return items[index.item]
    }
    
    func fetch() {
        
        for data in load("ExploreData") {
            items.append(ExploreItem(dic: data))
        }
        
    }
    
    
}
