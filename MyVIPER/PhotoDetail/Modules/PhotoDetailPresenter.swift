//
//  PhotoDetailPresenter.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import UIKit

protocol PhotoDetailPresenterInputProtocol: PhotoDetailViewControllerOutputProtocol, PhotoDetailInteractorOutputProtocol {
    
}

class PhotoDetailPresenter: PhotoDetailPresenterInputProtocol {

    
    var view: PhotoDetailViewControllerInputProtocol!
    var interactor: PhotoDetailInteractorInputProtocol!
    
    // Passing data from Photosearch module Routing
    // Отправляем запрос от View в Interactor
    func saveSelectedPhotoModel(photoModel: FlickrPhotoModel) {
        self.interactor.configurePhotoModel(photoModel: photoModel)
    }
    
    func loadLargePhotoImage() {
        self.interactor.loadUIImageFromUrl()
    }
    
    // Получаем данные от Interactor
    func sendLoadedPhotoImage(image: UIImage) {
        self.view.addLargeLoadedPhoto(image)
    }
    
    func getPhotoImageTitle() {
        let imageTitle = self.interactor.getPhotoImageTitle()
        self.view.addPhotoImageTitle(imageTitle)
    }
}
