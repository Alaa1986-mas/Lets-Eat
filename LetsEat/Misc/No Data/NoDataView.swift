//
//  NoDataView.swift
//  LetsEat
//
//  Created by עלאא דאהר on 07/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit

class NoDataView: UIView {

    var view: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: "NoDataView", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self, options: nil) [0] as! UIView
        return view
        
    }
    
    func setupView() {
        
        view = loadViewFromNib()
        view.bounds = bounds
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
    }
    
    func set(title: String) {
        lblTitle.text = title
    }
    
    func set(desc: String) {
        lblDesc.text = desc
    }
}
