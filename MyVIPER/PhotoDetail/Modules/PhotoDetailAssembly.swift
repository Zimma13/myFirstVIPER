//
//  PhotoDetailAssembly.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import UIKit

class PhotoDetailAssembly {
    
    static let sharedInstance = PhotoDetailAssembly()
    
    func configure(_ viewController: PhotoDetailViewController) {
        
        let APIDataManager: FlickrPhotoLoadImageProtocol = FlickrDataManager()
        let interactor = PhotoDetailInteractor()
        let presenter = PhotoDetailPresenter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.imageDataManager = APIDataManager
        
        
    }
    
}
