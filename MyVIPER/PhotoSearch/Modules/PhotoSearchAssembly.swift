//
//  PhotoSearchAssembly.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import Foundation

class PhotoSearchAssembly {
    
    static let sharedInstance = PhotoSearchAssembly()
    
    func configure(_ viewController: PhotoViewController) {
        
        let APIDataManager = FlickrDataManager()
        let interactor = PhotoSearchInteractor()
        let presenter = PhotoSearchPresenter()
        let router = PhotoSearchRouting()
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        
        router.viewController = viewController
        presenter.router = router
        
    }
    
}
