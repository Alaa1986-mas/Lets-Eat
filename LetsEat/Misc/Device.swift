//
//  Device.swift
//  LetsEat
//
//  Created by עלאא דאהר on 26/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation
import UIKit

struct Device {
    static var currentDevice: UIDevice {
        struct Singletone {
            static let device = UIDevice.current
        }
        return Singletone.device
    }
    
    static var isPhone: Bool {
        return currentDevice.userInterfaceIdiom == .phone
    }
    
    static var isPad: Bool {
        return currentDevice.userInterfaceIdiom == .pad
    }
}
