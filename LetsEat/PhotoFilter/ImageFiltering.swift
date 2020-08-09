//
//  ImageFiltering.swift
//  LetsEat
//
//  Created by עלאא דאהר on 14/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import Foundation
import UIKit
import CoreImage


protocol ImageFiltering {
    func apply(filter: String, orginalImage: UIImage) -> UIImage
}

protocol ImageFilterDelegate: class {
    func filterSelected(item: FilterItem)
}


extension ImageFiltering {
    func apply(filter: String, orginalImage: UIImage) -> UIImage {
        
        let initialCIImage = CIImage(image: orginalImage, options: nil)
        
        let orginalOrientation = orginalImage.imageOrientation
        
        guard let ciFilter = CIFilter(name: filter) else {
            print("filter not found")
            return UIImage()
        }
        ciFilter.setValue(initialCIImage, forKey: kCIInputImageKey)
        let context = CIContext()
        
        let filteredCIImage = ciFilter.outputImage!
        let filteredCGImage = context.createCGImage(filteredCIImage, from: filteredCIImage.extent)
        
        return UIImage(cgImage: filteredCGImage!, scale: 1.0, orientation: orginalOrientation)
        
        
        
    }
    
}
