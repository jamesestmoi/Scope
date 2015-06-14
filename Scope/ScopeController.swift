//
//  ScopeController.swift
//  
//
//  Created by James Pickering on 6/13/15.
//
//

import UIKit
import Cartography

protocol ScopeControllerDelegate {
    func scopes() -> [Scope]
    func data() -> [AnyObject]
    func filteredDataForScope(scope: Scope) -> [AnyObject]
}

class ScopeController: UIViewController, ScopeControllerDelegate {
    
    var barView: ScopeBarView!
    var containerView: ScopeContainerView!
    
    var currentScopeData = [AnyObject]()
    
    var currentScope: Scope!

    override func viewDidLoad() {
        super.viewDidLoad()

        barView = ScopeBarView(scopes: scopes())
        containerView = ScopeContainerView(numberOfScopes: scopes().count, scopeController: self)
        
        view.addSubview(barView)
        view.addSubview(containerView)
        
        layout(barView, containerView, view) { (bar, container, view) -> () in
            
            bar.top == view.top
            bar.left == view.left
            bar.right == view.right
            bar.height == 88
            
            container.top == bar.bottom
            container.left == view.left
            container.right == view.right
            container.bottom == view.bottom
        }
    }

    func scopes() -> [Scope] {
        return [Scope]()
    }
    
    func data() -> [AnyObject] {
        return [AnyObject]()
    }
    
    func filteredDataForScope(scope: Scope) -> [AnyObject] {
        return [AnyObject]()
    }
}
