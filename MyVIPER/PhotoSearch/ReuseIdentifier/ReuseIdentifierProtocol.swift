//
//  ReuseIdentifirProtocol.swift
//  MyVIPER
//
//  Created by Zimma on 18/12/2018.
//  Copyright © 2018 *Purple. All rights reserved.
//

import UIKit

public protocol ReuseIdentifierProtocol: class {
    //Get identifir from class
    static var defaultReuseIdentifier: String { get }
}

public extension ReuseIdentifierProtocol where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
}
