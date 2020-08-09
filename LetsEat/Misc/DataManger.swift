//
//  DataManger.swift
//  LetsEat
//
//  Created by עלאא דאהר on 30/06/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation


protocol DataManger {
    func load(_ fileName: String) -> [[String:AnyObject]]
}

extension DataManger {
    func load(_ fileName: String) -> [[String:AnyObject]] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"), let items = NSArray(contentsOfFile: path) else {
            return [[:]]
        }
        
        return items as! [[String:AnyObject]]
    }
}
