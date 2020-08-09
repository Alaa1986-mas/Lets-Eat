//
//  MapViewController.swift
//  LetsEat
//
//  Created by עלאא דאהר on 30/06/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = MapDataManger()
    
    var selectedResturant: ResturantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Segue.showDetail.rawValue:
            showResturantDetail(segue: segue)
        default:
            print("segue not added")
        }
    }


}





// MARK: Private Extenstion

private extension MapViewController {
    
    func initialize() {
        mapView.delegate = self
        manager.fetch { (annotations) in
          addMap(annotations)
        }
    }
    
    func addMap(_ annotations: [ResturantItem]) {
           mapView.setRegion(manager.currentRegion(latDelta: 0.5, longDelta: 0.5), animated: true)
           mapView.addAnnotations(manager.annotations)
       }
       
       func showResturantDetail(segue: UIStoryboardSegue) {
           if let viewController = segue.destination as? ResturantDetailViewController, let resturant = selectedResturant {
               viewController.selectedResturant = resturant
           }
       }
    
}


// MARK: MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
  
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "custompin"
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        var annotationView : MKAnnotationView?
        
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = customAnnotationView
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            annotationView = av
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "custom-annotation")
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = mapView.selectedAnnotations.first else { return }
        selectedResturant = annotation as? ResturantItem
        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
    }
}
