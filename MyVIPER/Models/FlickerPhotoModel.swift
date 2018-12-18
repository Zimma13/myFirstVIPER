//
//  FlickerPhotoModel.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import Foundation

/*
 Flickr Key : 0968d5fc7e3074b8d632ecd2a76afe11
 Secret: 0778f91d7e62d736
 */

struct FlickrPhotoModel {
    
    let photoID: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoURL: URL {
        return flickrImageURL()
    }
    
    var largePhotoUrl: URL {
        return flickrImageURL(size: "b")
    }
    
    private func flickrImageURL(size: String = "m") -> URL {

        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg")!
        
    }
}
