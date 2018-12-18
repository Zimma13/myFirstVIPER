//
//  PhotoViewController.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import UIKit

protocol PhotoViewControllerOutputProtocol {
    
    func fetchPhotos(_ searchtag: String, page: Int)
    func goToPhotoDetailScreen()
    
    // Go to Detail
    func passDataToNextScene(segue: UIStoryboardSegue)
}

protocol PhotoViewControllerInputProtocol {
    
    func displayFetchedPhotos(_ photos: [FlickrPhotoModel], totalPages: Int)
    func displayErrorView(_ errorMassage: String)
    
    // Alert loading indicator
    func showWaitingView()
    func hideWaitingView()
    func getTotalPhotoCount() -> Int
    
}

class PhotoViewController: UIViewController, PhotoViewControllerInputProtocol {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var presenter: PhotoViewControllerOutputProtocol!
    
    let photoSearchKey = "Party"
    
    var photos: [FlickrPhotoModel] = []
    var currentPage = 1
    var totalPages = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        PhotoSearchAssembly.sharedInstance.configure(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = photoSearchKey
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSearchWith(photoSearchKey)
        
    }
    
    func performSearchWith(_ searchText: String) {
        presenter.fetchPhotos(searchText, page: currentPage)
    }
    
    // Presenter return us with photo results
    func displayFetchedPhotos(_ photos: [FlickrPhotoModel], totalPages: Int) {
        self.photos.append(contentsOf: photos)
        self.totalPages = totalPages
        
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
        }
    }
    // Show error
    func displayErrorView(_ errorMassage: String) {
        let refreshAlert = UIAlertController(title: "Error", message: errorMassage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        refreshAlert.addAction(ok)
        present(refreshAlert, animated: true)
    }
    
    //MARK: - ActivityView
    func showWaitingView() {
        let alert = UIAlertController(title: nil, message: "Please waiting", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .gray
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func hideWaitingView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getTotalPhotoCount() -> Int {
        return photos.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.passDataToNextScene(segue: segue)
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if currentPage < totalPages {
            return photos.count + 1
        }
        
        return photos.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < photos.count {
            
            return photoItemCell(collectionView, cellForItemAt: indexPath)
            
        } else {
            
            currentPage += 1
            performSearchWith(photoSearchKey)
            return loadingItemCell(collectionView, cellForItemAt: indexPath)
        }
        
    }
    
    func photoItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.defaultReuseIdentifier, for: indexPath) as! PhotoItemCell
        
        let flickrPhoto = self.photos[indexPath.row]
        cell.photoImageView.alpha = 0
        cell.photoImageView.sd_setImage(with: flickrPhoto.photoURL) { (image, error, cache, url) in
            cell.photoImageView.image = image
            UIView.animate(withDuration: 0.2, animations: {
                cell.photoImageView.alpha = 1
            })
        }
        
        return cell
        
    }
    
    func loadingItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoLoadingCell.defaultReuseIdentifier, for: indexPath) as! PhotoLoadingCell
        return cell
        
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.goToPhotoDetailScreen()
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize: CGSize
        let langht = UIScreen.main.bounds.width / 3 - 1
        
        if indexPath.row < photos.count {
            
            itemSize = CGSize(width: langht, height: langht)
            
        } else {
            
            itemSize = CGSize(width: photoCollectionView.bounds.width, height: 50)
            
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}
