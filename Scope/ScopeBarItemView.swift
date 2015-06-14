//
//  ScopeBarItemView.swift
//  Scope
//
//  Created by James Pickering on 6/13/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class ScopeBarItemView: UIView {
    
    var title: String!
    var backgroundImage: UIImage!
    
    init(title: String, imageNamed: String) {
        
        self.title = title
        self.backgroundImage = UIImage(named: imageNamed)
        
        super.init(frame: CGRectZero)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
