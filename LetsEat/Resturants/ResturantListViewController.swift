//
//  ResturantListViewController.swift
//  LetsEat
//
//  Created by עלאא דאהר on 21/06/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit

class ResturantListViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedResturant: ResturantItem?
    var manager = ResturantDataManger()
    var selectedCity: LocationItem?
    var selectedType: String?
    
    fileprivate let minItemSpacing: CGFloat = 7.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
      initialize()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showDetail.rawValue:
               showResturantDetails(segue: segue)
            default:
                print("no segue added")
            }
        }
    }
    


}






// MARK: Private Extension

private extension ResturantListViewController {
    
    func initialize() {
        createData()
        setupTitle()
        setupCollectionView()
       
    }
    
    func setupCollectionView() {
      let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumLineSpacing = 7.0
        flow.minimumInteritemSpacing = 0.0
        
        collectionView.collectionViewLayout = flow
    }
    
    func setupTitle() {
       navigationController?.setNavigationBarHidden(false, animated: false)
        
        if let city = selectedCity?.city, let state = selectedCity?.state {
            title = "\(city.uppercased()), \(state.uppercased())"
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createData() {
        guard let location = selectedCity?.city, let type = selectedType else {
            return
        }
        
        manager.fetch(by: location, filter: type) { _ in
            if manager.numberOfItems() > 0 {
                collectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Resturants")
                view.set(desc: "No Resturants")
                collectionView.backgroundView = view
                
            }
            collectionView.reloadData()
        }
    }
    
    func showResturantDetails(segue: UIStoryboardSegue) {
        if let viewcontroller = segue.destination as? ResturantDetailViewController, let index = collectionView.indexPathsForSelectedItems?.first {
            
            let selectedResturant = manager.resturantItem(at: index)
                
                viewcontroller.selectedResturant = selectedResturant
          
            
        }
    }
    
}



// MARK: UICollectionViewDataSource

extension ResturantListViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resturantCell", for: indexPath) as! ResturantCell
        let item = manager.resturantItem(at: indexPath)
        
        if let name = item.name {
            cell.lblTitle.text = name
        }
        
        if let cuisine = item.subtitle {
            cell.lblCuisine.text = cuisine
        }
        
        if let image = item.imageURL {
            if let url = URL(string: image) {
                let data = try? Data(contentsOf: url)
                
                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.imgResturant.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
    
}


// MARK: UICollectionViewDelegateFlowLayout

extension ResturantListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var factor = 0
        var delta = 0
        
        if Device.isPad {
            factor = 3
            delta = -60
        } else {
            factor = traitCollection.horizontalSizeClass == .compact ? 1 : 2
            delta = -90
        }
        
        let screenRect = collectionView.frame.size.width
        let screenWidth = screenRect - (CGFloat(minItemSpacing) * CGFloat(factor + 1))
        let cellWidth = screenWidth / CGFloat(factor)
        let cellHeight = cellWidth - CGFloat(delta)
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
}
