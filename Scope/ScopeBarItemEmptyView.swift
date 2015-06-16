//
//  ScopeEmptyBarItemView.swift
//  Scope
//
//  Created by James Pickering on 6/15/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class ScopeBarItemEmptyView: UIView {

    init() {
        super.init(frame: CGRectZero)
        backgroundColor = UIColor.greenColor()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
