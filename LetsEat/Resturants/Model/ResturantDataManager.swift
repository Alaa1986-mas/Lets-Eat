//
//  ResturantDataManager.swift
//  LetsEat
//
//  Created by עלאא דאהר on 07/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation

class ResturantDataManger {
    private var items: [ResturantItem] = []
    
    func fetch(by location: String, filter: String = "All", complationHandler: ([ResturantItem]) -> Void) {
        
        if let file = Bundle.main.url(forResource: location, withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                
                let resturants = try JSONDecoder().decode([ResturantItem].self, from: data)
                
                if filter != "All" {
                    items = resturants.filter({$0.cuisines.contains(filter)})
                } else {
                    items = resturants
                }
            } catch {
                print("there was error \(error)")
            }
            
            complationHandler(items)
            
            
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func resturantItem(at index: IndexPath) -> ResturantItem {
        return items[index.item]
    }
}
