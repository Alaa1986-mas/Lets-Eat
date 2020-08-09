//
//  PhotoFilterViewController.swift
//  LetsEat
//
//  Created by עלאא דאהר on 15/07/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class PhotoFilterViewController: UIViewController {
    
    let manager = FilterManger()
    var image : UIImage?
    var thumbnail: UIImage?
    var data: [FilterItem] = []
    var selectedResturantId: Int?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgExample: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
    

   

}





// MARK: Private Extension

private extension PhotoFilterViewController {
    
    func initialize() {
       requestAccess()
       setupCollectionView()
       checkSource()
    }
    
    func requestAccess() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
            if granted {}
        }
    }
    
    func setupCollectionView() {
     
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layout.minimumLineSpacing = 7.0
        layout.minimumInteritemSpacing = 0.0
        
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func checkSource() {
        
        let cameraMediaType = AVMediaType.video
        let cameraAuthorziationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorziationStatus {
        case .authorized:
            self.showCameraUserInterface()
        case .denied, .restricted:
            break
       
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: cameraMediaType) { (granted) in
                if granted {
                    self.showCameraUserInterface()
                }
            }
            
        default:
            print("unknown")
        
    }
    }
    
    func checkSavedPhoto() {
        if let img = self.imgExample.image {
            var item = ResturantPhotoItem()
            item.photo = generate(img: img, ratio: 102)
            item.date = NSDate() as Date
            item.resturantId = self.selectedResturantId
            
            let manager = CoreDataManager()
            manager.addPhoto(item)
            
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func onSaveTapped(sender: Any) {
        DispatchQueue.main.async {
            self.checkSavedPhoto()
        }
          
      }
    
    
    func showApplyFilter() {
        manager.fetch { (items) in
            if data.count > 0 { data.removeAll() }
            
            data = items
            
            if let image = self.image {
                imgExample.image = image
                collectionView.reloadData()
            }
        }
    }
    
    func filterItem(at indexPath: IndexPath) -> FilterItem {
        
        return data[indexPath.item]
    }
    
    @IBAction func onPhotoTapped(_ sender: Any) {
        checkSource()
    }
    
    
    func showCameraUserInterface() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
         #if targetEnvironment(simulator)
           
           imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
           
           #else
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
           imagePicker.showsCameraControls = true
          
           
           #endif
        
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        
           
    }
    
    func generate(img: UIImage, ratio: CGFloat) -> UIImage {
        let size = img.size
        var croppedSize: CGSize?
        var offsetX: CGFloat = 0.0
        var offsetY: CGFloat = 0.0
        
        if size.width > size.height {
         
            offsetX = (size.height - size.width) / 2.0
            croppedSize = CGSize(width: size.height, height: size.height)
            
        } else {
            offsetY = (size.width - size.height) / 2.0
             croppedSize = CGSize(width: size.width, height: size.width)
            
        }
        
        guard let cropped = croppedSize, let cgImage = img.cgImage else {
            return UIImage()
        }
        let clippedRect = CGRect(x: offsetX * -1, y: offsetY * -1, width: cropped.width, height: cropped.height)
        let imgRef = cgImage.cropping(to: clippedRect)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: ratio, height: ratio)
        
        UIGraphicsBeginImageContext(rect.size)
        if let ref = imgRef {
            UIImage(cgImage: ref).draw(in: rect)
        }
        
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let thumb = thumbnail else {
            return UIImage()
        }
        
        return thumb
    }
    
   
    
    
}



// MARK: UICollectionViewDataSource

extension PhotoFilterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCell
        
        let item = data[indexPath.row]
        
        if let image = self.thumbnail {
            cell.set(image: image, item: item)
        }
        
        return cell
        
        
    }
    
}


// MARK: UICollectionViewDelegateFlowLayout

extension PhotoFilterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = collectionView.frame.size.height
        
        let screenHt = screenRect - 14
        
        return CGSize(width: 150, height: screenHt)
    }
}


// MARK: UIImagePickerControllerDelegate

extension PhotoFilterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        if let img = image {
            self.thumbnail = generate(img: img, ratio: 102)
            
            self.image = generate(img: img, ratio: 702)
            
        }
        
        picker.dismiss(animated: true) {
            self.showApplyFilter()
        }
    }
    
}



// MARK: ImageFilteringDelegate

extension PhotoFilterViewController: ImageFiltering, ImageFilterDelegate {
    
    func filterSelected(item: FilterItem) {
        
        let filteredImage = image
        if let img = filteredImage {
            if item.name != "None" {
                imgExample.image = self.apply(filter: item.filter, orginalImage: img)
            } else {
                imgExample.image = img
            }
        }
    }
    
}







// MARK: UICollectionViewDelegate

extension PhotoFilterViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.data[indexPath.row]
        filterSelected(item: item)
    }
}
