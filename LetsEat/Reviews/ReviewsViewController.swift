//
//  ReviewsViewController.swift
//  LetsEat
//
//  Created by עלאא דאהר on 21/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedResturantId: Int?
    var data: [ReviewItem] = []
    
    let manager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilaize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDefaults()
    }
    



}






// MARK: Private Extension

private extension ReviewsViewController {
    
    func initilaize() {
      setupCollectionView()
    }
    
    func setupDefaults() {
       checkReviews()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layout.minimumLineSpacing = 7.0
        layout.minimumInteritemSpacing = 0.0
     
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
    }
    
    func checkReviews() {
        
        if let viewController = self.parent as? ResturantDetailViewController {
            if let id = viewController.selectedResturant?.resturantId {
                if data.count > 0 { data.removeAll() }
                
                data = manager.fetchReviews(by: id)
                
                if data.count > 0 {
                    collectionView.backgroundView = nil
                } else {
                   let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.size.width, height: collectionView.frame.size.width))
                    view.set(title: "Reviews")
                    view.set(desc: "There are currently no reviews")
                    
                    collectionView.backgroundView = view
                
                }
                collectionView.reloadData()
            }
        }
    }
}







// MARK: UICollectionViewDataSource

extension ReviewsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        let item = data[indexPath.item]
        cell.lblName.text = item.name
        cell.lblTitle.text = item.title
        cell.lblReview.text = item.customerReview
        cell.lblDate.text = item.displayDate
        if let rating = item.rating {
            cell.ratingView.rating = CGFloat(rating)
        }
        
        return cell
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
}



// MARK: UICollectionViewDelegateFlowLayout

extension   ReviewsViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if data.count == 1 {
            let width = collectionView.frame.size.width - 14
            
            return CGSize(width: width, height: 200)
        } else {
          
            let width = collectionView.frame.size.width - 21
            return CGSize(width: width, height: 200)
        }
        
      
    }
    
}


