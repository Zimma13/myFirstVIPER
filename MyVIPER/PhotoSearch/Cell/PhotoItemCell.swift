//
//  PhotoItemCell.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import UIKit

class PhotoItemCell: UICollectionViewCell, ReuseIdentifierProtocol {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
}
