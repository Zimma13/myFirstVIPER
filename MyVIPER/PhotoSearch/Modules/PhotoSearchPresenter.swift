//
//  PhotoSearchPresenter.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import UIKit

protocol PhotoSearchPresenterInputProtocol: PhotoViewControllerOutputProtocol, PhotoSearchInteractorOutputProtocol {
    
}

class PhotoSearchPresenter: PhotoSearchPresenterInputProtocol {
    
    var view: PhotoViewControllerInputProtocol!
    var interactor: PhotoSearchInteractorInputProtocol!
    var router: PhotoSearchRouterInputProtocol!
    
    // Presenter says interactor ViewController needs photos
    func fetchPhotos(_ searchtag: String, page: Int) {
        
        if view.getTotalPhotoCount() == 0 {
            view.showWaitingView()
        }
        interactor.fetchAllPhotosFromDataManager(searchtag, page: page)
    }
    
    // Service return photos and interactor passes all data to presenter which make view display them
    func providedPhotos(_ photos: [FlickrPhotoModel], totalPages: Int) {
        self.view.hideWaitingView()
        self.view.displayFetchedPhotos(photos, totalPages: totalPages)
    }
    
    // Show error massage
    func serviceError(_ error: Error) {
        self.view.displayErrorView("ERROR: \(error)")
    }
    
    func goToPhotoDetailScreen() {
        self.router.navigateToPhotoDetail()
    }
    
    // Go to Detail
    func passDataToNextScene(segue: UIStoryboardSegue) {
        self.router.passDataToNextScene(segue: segue)
    }
}
