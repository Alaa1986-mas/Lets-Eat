//
//  CoreDataManager.swift
//  LetsEat
//
//  Created by עלאא דאהר on 17/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    let container:  NSPersistentContainer
    override init() {
        container = NSPersistentContainer(name: "LetsEatModel")
        
        container.loadPersistentStores { (Desc, error) in
            guard error == nil  else {
                print(error?.localizedDescription as Any)
                return
            }
            
        
        }
        super.init()
    }
    
    func addReview(_ item: ReviewItem) {
        let review = Review(context: container.viewContext)
        
        review.name = item.name
        review.title = item.title
        review.date = Date()
        
        if let rating = item.rating {
            review.rating = rating
        }
        
        review.customerReview = item.customerReview
        review.uuid = item.uuid
        
        
        if let resturantId = item.resturantId {
            review.resturantId = Int32(resturantId)
            print("resturant id \(resturantId)")
            save()
            
        }
    }
    
    
    func addPhoto(_ item: ResturantPhotoItem) {
        
        let photo = ResturantPhoto(context: container.viewContext)
        
        photo.date = Date()
        photo.photo = item.photoData as Data
        photo.uuid = item.uuid
        
        if let resturantId = item.resturantId {
            photo.resturantId = Int32(resturantId)
            print("resturant id \(resturantId)")
            save()
            
        }
    }
    
    func fetchReviews(by identifier: Int) -> [ReviewItem] {
        let moc = container.viewContext
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        
        let predicate = NSPredicate(format: "resturantId = %i", Int32(identifier))
        
        var items: [ReviewItem] = []
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        
        do {
            for data in try moc.fetch(request) {
                items.append(ReviewItem(data: data))
            }
            return items
            
        }catch {
            fatalError("failed to fetch reviews: \(error)")
        }
        
    }
    
    func fetchPhotos(by identifier: Int) -> [ResturantPhotoItem] {
        let moc = container.viewContext
        
        let request: NSFetchRequest<ResturantPhoto> = ResturantPhoto.fetchRequest()
        
        let predicate = NSPredicate(format: "resturantId = %i", Int32(identifier))
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        var items: [ResturantPhotoItem] = []
        
        request.predicate = predicate
        
        do {
            for data in try moc.fetch(request) {
                items.append(ResturantPhotoItem(data: data))
            }
            return items
            
        }catch {
            fatalError("failed to fetch photos \(error)")
        }
    }
    
    func fetchResturantRating(by identifier: Int) -> Float {
        
        let reviews = fetchReviews(by: identifier).map({$0})
        
        let sum = reviews.reduce(0, {$0 + ($1.rating ?? 0)})
        
        return sum / Float(reviews.count)
        
    }
    
    fileprivate func save() {
        do {
            if container.viewContext.hasChanges {
                try container.viewContext.save()
                print("saved")
            }
            
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
}
