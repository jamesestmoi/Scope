//
//  ScopeBarItemView.swift
//  Scope
//
//  Created by James Pickering on 6/13/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class ScopeBarItemView: UIButton {
    
    var title: String!
    var backgroundImage: UIImage!
    var barView: ScopeBarView!
    var index: Int = 0
    
    init(title: String, imageNamed: String, barView: ScopeBarView!, index: Int) {
        
        self.barView = barView
        self.index = index
        self.title = title
        self.backgroundImage = UIImage(named: imageNamed)
        
        super.init(frame: CGRectZero)
        
        backgroundColor = UIColor.yellowColor()
        
        setTitle(title, forState: .Normal)
        
        addTarget(barView.scopeController, action: "centerView:", forControlEvents: .TouchUpInside)
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
