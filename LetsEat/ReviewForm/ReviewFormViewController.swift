//
//  ReviewFormViewController.swift
//  LetsEat
//
//  Created by עלאא דאהר on 13/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit

class ReviewFormViewController: UITableViewController {
    
    @IBOutlet weak var ratingView: RatingsView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tvReview: UITextView!
    
    var selectedResturanId: Int?
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
   
        print(selectedResturanId as Any)
        

    }

}




// MARK: Private Extension

private extension ReviewFormViewController {
  
    @IBAction func onSaveTapped(_ sender: Any) {
          
        var item = ReviewItem()
        item.name = tfName.text
        item.title = tfTitle.text
        item.customerReview = tvReview.text
        item.rating = Float(ratingView.rating)
        item.resturantId = selectedResturanId
        
        let manager = CoreDataManager()
        manager.addReview(item)
        
        dismiss(animated: true, completion: nil)
      }
}
