//
//  Scope.swift
//  Scope
//
//  Created by James Pickering on 6/13/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class Scope: NSObject {
   
    var title: String
    var image: UIImage
    var query: AnyObject
    
    init(title: String, imageNamed: String, query: String) {
        self.title = title
        self.image = UIImage()
        self.query = query
        
        super.init()
    }
}
