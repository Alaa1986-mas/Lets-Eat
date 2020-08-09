//
//  LocationDataManger.swift
//  LetsEat
//
//  Created by עלאא דאהר on 29/06/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation

class LocationDataManger : DataManger {
    private var locations: [LocationItem] = []
    
    func fetch() {
        for location in load("Locations") {
          
            locations.append(LocationItem(dic: location))
            
        }
    }
    
    func numberOfItems() -> Int {
        return locations.count
    }
    
    func locationItem(at index: IndexPath) -> LocationItem {
        return locations[index.item]
    }
    
    func findLocation(by name: String) ->(isFound: Bool, position: Int) {
        
        guard let index = locations.firstIndex(where: {$0.city == name}) else {
            return (isFound: false, position: 0)
        }
        
        return (isFound: true, position: index)
        
        
    }
    

}
