//
//  PhotoDetailInteractor.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import UIKit

protocol PhotoDetailInteractorOutputProtocol: class {
    func sendLoadedPhotoImage(image: UIImage)
}

protocol PhotoDetailInteractorInputProtocol: class {
    func configurePhotoModel(photoModel: FlickrPhotoModel)
    func loadUIImageFromUrl()
    func getPhotoImageTitle() -> String
}

class PhotoDetailInteractor: PhotoDetailInteractorInputProtocol {
    func sendLoadedPhotoImage(image: UIImage) {
        
    }
    
    
    var presenter: PhotoDetailInteractorOutputProtocol!
    var photoModel: FlickrPhotoModel?
    
    var imageDataManager: FlickrPhotoLoadImageProtocol!
    
    func configurePhotoModel(photoModel: FlickrPhotoModel) {
        self.photoModel = photoModel
    }
    
    func loadUIImageFromUrl() {
        imageDataManager.loadImageFromUrl(self.photoModel!.largePhotoUrl) { (image, error) in
            
            if let image = image {
                self.presenter.sendLoadedPhotoImage(image: image)
            }
            
        }
    }
    
    func getPhotoImageTitle() -> String {
        if let title = self.photoModel?.title {
            return title
        } else {
            return ""
        }
    }
}
