//
//  PhotoDetailViewController.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerInputProtocol {
    func addLargeLoadedPhoto(_ photo: UIImage)
    func addPhotoImageTitle(_ imageTitle: String)
}

protocol PhotoDetailViewControllerOutputProtocol {
    func saveSelectedPhotoModel(photoModel: FlickrPhotoModel)
    func loadLargePhotoImage()
    func getPhotoImageTitle()
}

class PhotoDetailViewController: UIViewController, PhotoDetailViewControllerInputProtocol {
    
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var presenter: PhotoDetailViewControllerOutputProtocol!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        PhotoDetailAssembly.sharedInstance.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ask title and image from presenter
        self.presenter.getPhotoImageTitle()
        self.presenter.loadLargePhotoImage()
    }

    func addLargeLoadedPhoto(_ photo: UIImage) {
        photoImageView.image = photo
    }
    
    func addPhotoImageTitle(_ imageTitle: String) {
        photoTitleLabel.text = imageTitle
    }
    
}
