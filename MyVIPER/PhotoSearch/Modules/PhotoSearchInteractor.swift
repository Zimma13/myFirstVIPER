//
//  PhotoSearchInteractor.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import Foundation

protocol PhotoSearchInteractorInputProtocol {
    func fetchAllPhotosFromDataManager(_ searchTag: String, page: Int)
}

protocol PhotoSearchInteractorOutputProtocol {
    // PhotoSearchPresenter
    // Service return photos and interactor passes all data to presenter which make view display them
    func providedPhotos(_ photos: [FlickrPhotoModel], totalPages: Int)
    
    // Show error massage
    func serviceError(_ error: Error)
}

class PhotoSearchInteractor: PhotoSearchInteractorInputProtocol {
    
    var presenter: PhotoSearchInteractorOutputProtocol!
    var APIDataManager: FlickrPhotoSearchProtocol!
    
    func fetchAllPhotosFromDataManager(_ searchTag: String, page: Int) {
        
        APIDataManager.fetchPhotosFor(searchText: searchTag, page: page) { (error, totalPages, flickrPhotos) in
            
            if let photos = flickrPhotos {
                
                self.presenter.providedPhotos(photos, totalPages: totalPages)
                
            } else if let error = error {
                
                func serviceError(_ error: Error) {
                    
                    self.presenter.serviceError(error)
                    
                }
            }
        }
    }
    
}
