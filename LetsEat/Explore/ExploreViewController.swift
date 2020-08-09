//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by עלאא דאהר on 17/06/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDelegate {
   
    var givenName: String?
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    let manager = ExploreDataManger()
    var selectedCity: LocationItem?
    var headerView: ExploreHeaderView!
   
    fileprivate let minItemSpace: CGFloat = 7.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilaize()
   
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.locationList.rawValue:
            showLocationList(segue: segue)
        case Segue.resturantList.rawValue:
            showResturantList(segue: segue)
        default:
            print("Segue not added")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Segue.resturantList.rawValue {
            guard selectedCity != nil else {
              
                showAlert()
                return false
                
            }
            return true
        }
        
        return true
    }
    
    


}




// MARK: Private Extension

private extension ExploreViewController {
    
    func initilaize() {
        manager.fetch()
        setupCollectionView()
    }
    
    
    func setupCollectionView() {
       
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumLineSpacing = 7
        flow.minimumInteritemSpacing = 0
        
        collectionView.collectionViewLayout = flow
        
    }
    
    func showResturantList(segue: UIStoryboardSegue) {
        if let viewcontroller = segue.destination as? ResturantListViewController, let city = selectedCity, let index = collectionView.indexPathsForSelectedItems?.first {
            viewcontroller.selectedCity = city
                viewcontroller.selectedType = manager.explore(at: index).name
        }
        
    
        
    }
    
    func showLocationList(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? LocationViewController else {
            return
        }
        
        guard let city = selectedCity else { return }
        
        viewController.selectedCity = city
    }
    
    
    func showAlert() {
        let alertController = UIAlertController(title: "Location Needed", message: "Please Select Location", preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func unwindLocationCancel(segue: UIStoryboardSegue) {
         
     }
    
    @IBAction func unwindLocationDone(segue: UIStoryboardSegue) {
        if let viewcontroller = segue.source as? LocationViewController {
            selectedCity = viewcontroller.selectedCity
            
            if let location = selectedCity {
                headerView.lblLocation.text = location.full
            }
        }
    }
}


// MARK: UICollectionViewDataSource

extension ExploreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        
            headerView = header as? ExploreHeaderView
        
        if let givenName = givenName {
            headerView.lblMain.text = "Hi, \(givenName)"
        }
           
           return headerView
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return manager.numberOfItems()
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
           let item = manager.explore(at: indexPath)
           cell.lblName.text = item.name
           cell.imgExplore.image = UIImage(named: item.image)
           
           return cell
           
       }
    
}



// MARK: UICollectionViewDelegateFlowLayout

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        view.layoutIfNeeded()
      
        
        var factor = 0
        var delta = 0
        
        if Device.isPad {
            factor = 3
            delta = 50
        } else {
            factor = traitCollection.horizontalSizeClass == .compact ? 2 : 3
            delta = traitCollection.horizontalSizeClass == .compact ? 10 : 70
            
           
        }
        let screenRect = collectionView.frame.size.width
                   
        let screenWidth = screenRect - (CGFloat(minItemSpace * CGFloat(factor + 1)))
                   
        let cellWidth = screenWidth / CGFloat(factor)
                   
        let cellHeight = cellWidth - CGFloat(delta)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: 100)
    }
    
}

