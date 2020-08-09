//
//  ResturantDetailViewController.swift
//  LetsEat
//
//  Created by עלאא דאהר on 05/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit
import MapKit

class ResturantDetailViewController: UITableViewController {

    // Nav Bar
    @IBOutlet weak var btnHeart: UIBarButtonItem!
    
    
    // Cell One
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCuisine: UILabel!
    @IBOutlet weak var lblHeaderAddress: UILabel!
    
    // Cell Two
    @IBOutlet weak var lblTableDetails: UILabel!
    
    // Cell Three
    @IBOutlet weak var lblOverallRating: UILabel!
    @IBOutlet weak var ratingView: RatingsView!
    
    // Cell Eight
    @IBOutlet weak var lblAddress: UILabel!
    
    // Cell Nine
    @IBOutlet weak var imgMap: UIImageView!
    
    
    var selectedResturant: ResturantItem?
    
    let manager = CoreDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            
            switch identifier {
            case Segue.showReview.rawValue:
                showReview(segue: segue)
            case Segue.showPhotoFilter.rawValue:
                showPhotoFilter(segue: segue)
             default:
                print("no segue added")
            }
            
        }
    }
    
  

   

}




// MARK: Private Extension
extension ResturantDetailViewController {
    
    func initialize() {
        setupLabels()
        createMap()
        createRating()
    }
    
    func setupLabels() {
        guard let resturant = selectedResturant else { return }
        
        if let name = resturant.name {
            lblName.text = name
            title = name
        }
        
        if let cuisine = resturant.subtitle {
            lblCuisine.text = cuisine
        }
        
        if let address = resturant.address {
            lblAddress.text = address
            lblHeaderAddress.text = address
        }
        
        lblTableDetails.text = "Table for 7, tonight at 10:00 PM"
    }
    
    func createMap() {
        guard let annotation = selectedResturant, let lat = annotation.lat, let long = annotation.long else { return }
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        takeSnapShot(with: location)
        
        
    }
    
    func showReview(segue: UIStoryboardSegue) {
      
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? ReviewFormViewController else {
            return
        }
        
        viewController.selectedResturanId = selectedResturant?.resturantId
        
        
    }
    
    func showPhotoFilter(segue: UIStoryboardSegue) {
        
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? PhotoFilterViewController else {
            return
        }
        
        viewController.selectedResturantId = self.selectedResturant?.resturantId
        
    }
    
    func createRating() {
        ratingView.isEnabled = true
        
        if let id = selectedResturant?.resturantId {
            let value = manager.fetchResturantRating(by: id)
            ratingView.rating = CGFloat(value)
            if value.isNaN {
                lblOverallRating.text = "0.0"
            } else {
                let roundedValue = ((value * 10).rounded() / 10)
                lblOverallRating.text = "\(roundedValue)"
            }
        }
    }
    
    @IBAction func unwindReviewCancel(segue: UIStoryboardSegue) {
          
      }
    
    func takeSnapShot(with location: CLLocationCoordinate2D) {
        let mapSnapShotOptions = MKMapSnapshotter.Options()
        
        var loc = location
        
        let polyline = MKPolyline(coordinates: &loc, count: 1)
        
        let region = MKCoordinateRegion(polyline.boundingMapRect)
        
        mapSnapShotOptions.region = region
        mapSnapShotOptions.scale = UIScreen.main.scale
        mapSnapShotOptions.size = CGSize(width: 374, height: 208)
        mapSnapShotOptions.showsBuildings = true
        mapSnapShotOptions.pointOfInterestFilter = .includingAll
        
        let snapShotter = MKMapSnapshotter(options: mapSnapShotOptions)
        
        snapShotter.start { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            UIGraphicsBeginImageContextWithOptions(mapSnapShotOptions.size, true, 0)
            snapshot.image.draw(at: .zero)
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.image = UIImage(named: "custom-annotation")
            
            let pinImage = pinView.image
            
            var point = snapshot.point(for: location)
            
            let rect = self.imgMap.bounds
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                
                point.x -= pinView.bounds.size.width / 2.0
                point.y -= pinView.bounds.size.height / 2.0
                
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                
                pinImage?.draw(at: point)
            }
            
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                
                DispatchQueue.main.async {
                    self.imgMap.image = image
                }
            }
            
            
            
            
            
        }
        
    }
    
}
