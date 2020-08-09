//
//  MapDataManger.swift
//  LetsEat
//
//  Created by עלאא דאהר on 29/06/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation
import MapKit

class MapDataManger : DataManger {
    fileprivate var items: [ResturantItem] = []
    
    var annotations: [ResturantItem] {
        return items
    }
    
    func fetch(completion:(_ annotation:[ResturantItem])-> ()) {
        
        if items.count > 0 { items.removeAll() }
        
            let manager = ResturantDataManger()
            manager.fetch(by: "Boston") { (items) in
                self.items = items
                completion(items)
            }
      
        
        
        
    }
    
    func currentRegion(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion {
        
        guard let item = items.first else {
            return MKCoordinateRegion()
        }
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        return MKCoordinateRegion(center: item.coordinate, span: span)
        
    }
 
    
}
