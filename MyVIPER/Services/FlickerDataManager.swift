//
//  FlickerDataManager.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import Foundation
import SDWebImage

protocol FlickrPhotoSearchProtocol: class {
    func fetchPhotosFor(searchText: String, page: Int, clousure: @escaping (Error?, Int, [FlickrPhotoModel]?) -> Void) -> Void
}

protocol FlickrPhotoLoadImageProtocol: class {
    func loadImageFromUrl(_ url: URL, clousere: @escaping (UIImage?, Error?) -> Void)
}

class FlickrDataManager: FlickrPhotoSearchProtocol, FlickrPhotoLoadImageProtocol {
    
    struct Errors {
        static let invalidAccessErrorCode = 100
    }
    
    struct FlicrApiMetadataKeys {
        static let failureStatusCode = "code"
    }
    
    struct FlickrAPI {
        
        static let APIKey = "0968d5fc7e3074b8d632ecd2a76afe11"
        static let tagsSearchFormat = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&page=%i&format=json&nojsoncallback=1"
        
    }
    
    func fetchPhotosFor(searchText: String, page: Int, clousure: @escaping (Error?, Int, [FlickrPhotoModel]?) -> Void) -> Void {
        
        let escapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let format = FlickrAPI.tagsSearchFormat
        let arguments: [CVarArg] = [FlickrAPI.APIKey, escapedSearchText!, page]
        let photosURL = String(format: format, arguments: arguments)
        
        let url = URL(string: photosURL)!
        let request = URLRequest(url: url as URL)
        
        let searchTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Error fetching photos: \(error!)")
                clousure(error as NSError?, 0, nil)
            }
            
            do {
                
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                
                guard let results = resultsDictionary else { return }
                
                if let statusCode = results[FlicrApiMetadataKeys.failureStatusCode] as? Int {
                    if statusCode == Errors.invalidAccessErrorCode {
                        let invalideAccessError = NSError(domain: "FlickrAPIDomain", code: statusCode, userInfo: nil)
                        clousure(invalideAccessError, 0, nil)
                        return
                    }
                }
                
                guard let photosContainer = resultsDictionary!["photos"] as? NSDictionary else { return }
                
                guard let totalPageCountString = photosContainer["total"] as? String else { return }
                guard let totalPageCount = Int(totalPageCountString) else { return }
                
                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }
                
                let flickrPhotos: [FlickrPhotoModel] = photosArray.map({ (photoDictionary) -> FlickrPhotoModel in
                    
                    let photoId = photoDictionary["id"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let secret = photoDictionary["secret"] as? String ?? ""
                    let server = photoDictionary["server"] as? String ?? ""
                    let title = photoDictionary["title"] as? String ?? ""
                    
                    let flickrPhoto = FlickrPhotoModel(photoID: photoId, farm: farm, secret: secret, server: server, title: title)
                    
                    return flickrPhoto
                    
                })
                
                clousure(nil, totalPageCount, flickrPhotos)
                
            } catch let error as NSError {
                
                print("Error parsing JSON: \(error)")
                clousure(error, 0, nil)
                
            }
            
        }
        searchTask.resume()
    }
    
    // Memory Cache Photo Servise
    
    func loadImageFromUrl(_ url: URL, clousere: @escaping (UIImage?, Error?) -> Void) {
        
        SDWebImageManager.shared().loadImage(with: url, options: .cacheMemoryOnly, progress: nil) { (image, data, error, cache, finished, withUrl) in
            clousere(image, error)
        }
        
    }
    
}
