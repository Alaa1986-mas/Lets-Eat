//
//  ExploreCell.swift
//  LetsEat
//
//  Created by עלאא דאהר on 28/06/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var imgExplore: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedCorners()
    }
}


// MARK: Private Extension

extension ExploreCell {
    
    func roundedCorners() {
        self.imgExplore.layer.cornerRadius = 9.0
        self.imgExplore.layer.masksToBounds = true
    }
    
}
