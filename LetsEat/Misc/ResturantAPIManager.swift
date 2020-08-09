//
//  ResturantAPIManager.swift
//  LetsEat
//
//  Created by עלאא דאהר on 05/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation

struct ResturantAPIManger {
    
    static func loadJSON(file name: String) -> [[String:AnyObject]] {
        
        var items = [[String:AnyObject]]()
        
        guard let path = Bundle.main.path(forResource: name, ofType: "json"), let data = NSData(contentsOfFile: path) else {
            return [[:]]
        }
        
        
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as AnyObject
            
            if let resturants = json as? [[String:AnyObject]] {
                items = resturants as [[String:AnyObject]]
            }
            
        } catch {
            
            print("error \(error)")
            return [[:]]
        }
        
        return items
        
    }
}
