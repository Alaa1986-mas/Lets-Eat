//
//  PhotosViewController.swift
//  LetsEat
//
//  Created by עלאא דאהר on 22/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data: [ResturantPhotoItem] = []
    
    let manager = CoreDataManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilaize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkPhotos()
    }
    


}




// MARK: Private Extension

private extension PhotosViewController {
    
    func initilaize() {
      setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 100.0
        layout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = layout
        
    }
    
    
    func checkPhotos() {
        if let viewcontroller = self.parent as? ResturantDetailViewController {
            if let id = viewcontroller.selectedResturant?.resturantId {
                
                if data.count > 0 { data.removeAll() }
                
                data = manager.fetchPhotos(by: id)
                
                if data.count > 0 {
                    collectionView.backgroundView = nil
                } else {
                    let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.size.width, height: collectionView.frame.size.height))
                    view.set(title: "Photos")
                    view.set(desc: "There are currently no photos")
                    
                    collectionView.backgroundView = view
                    
                    
                    
                }
                
                collectionView.reloadData()
            }
        }
    }
    
}



// MARK: UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let item = data[indexPath.item]
        
        if let img = item.photo {
            cell.imageView.image = img
            cell.roundedImage()
        } else {
          //  cell.contentView.backgroundColor = .none
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}



// MARK: UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
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

