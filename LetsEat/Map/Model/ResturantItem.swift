//
//  ResturantItem.swift
//  LetsEat
//
//  Created by עלאא דאהר on 29/06/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ResturantItem: NSObject, MKAnnotation, Decodable {
    var name: String?
    var cuisines: [String] = []
    var lat: Double?
    var long: Double?
    var address: String?
    var postalCode: String?
    var state: String?
    var imageURL: String?
    var resturantId: Int?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case long
        case name
        case cuisines
        case address
        case postalCode = "postal_code"
        case state
        case imageURL = "image_url"
        case resturantId = "id"
    }
    

    
    var subtitle: String? {
        if cuisines.isEmpty { return "" }
        else if cuisines.count == 1  { return cuisines.first }
        else { return cuisines.joined(separator: ", ") }
    }
    
    var title: String? {
        return name
    }
    
    
    var coordinate: CLLocationCoordinate2D {
        guard let lat = lat, let long = long else {
            return CLLocationCoordinate2D()
        }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
}
