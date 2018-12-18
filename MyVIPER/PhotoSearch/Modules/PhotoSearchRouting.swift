//
//  PhotoSearchRouting.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import UIKit

protocol PhotoSearchRouterInputProtocol: class {
    func navigateToPhotoDetail()
    func passDataToNextScene(segue: UIStoryboardSegue)
}

class PhotoSearchRouting: PhotoSearchRouterInputProtocol {
    
    var viewController: PhotoViewController!
    
    //MARK: - Navigation
    func navigateToPhotoDetail() {
        viewController.performSegue(withIdentifier: "ShowDetailVC", sender: nil)
    }
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        if segue.identifier == "ShowDetailVC" {
            passDataToShowPhotoDetailScene(segue: segue)
        }
    }
    
    // navigate to another module
    func passDataToShowPhotoDetailScene(segue: UIStoryboardSegue) {
        if let selectedIndexPath = viewController.photoCollectionView.indexPathsForSelectedItems?.first {
            let selectidPhotoModel = viewController.photos[selectedIndexPath.row]
            let showDetailViewController = segue.destination as! PhotoDetailViewController
            
            showDetailViewController.presenter.saveSelectedPhotoModel(photoModel: selectidPhotoModel)
        }
    }
    
}


