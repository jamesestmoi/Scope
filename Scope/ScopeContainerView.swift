//
//  ScopeContainerView.swift
//  Scope
//
//  Created by James Pickering on 6/13/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit
import Cartography

class ScopeContainerView: UIView, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController!
    var scopeController: ScopeController!
    var numberOfScopes: Int = 0
    
    init(numberOfScopes: Int, scopeController: ScopeController) {
        
        self.numberOfScopes = numberOfScopes
        self.scopeController = scopeController
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        
        super.init(frame: CGRectZero)
        
        pageViewController.dataSource = self
        
        if numberOfScopes > 0 {
            let first = getViewController(0)
            let starting = [first!]
            pageViewController.setViewControllers(starting, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        scopeController.addChildViewController(pageViewController)
        addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(scopeController)
        
        layout(pageViewController.view, self) { (page, superview) -> () in
            page.left == superview.left
            page.right == superview.right
            page.top == superview.top
            page.bottom == superview.bottom
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let controller = viewController as! ScopeTableViewController
        
        if controller.index > 0 {
            return getViewController(controller.index - 1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let controller = viewController as! ScopeTableViewController
        
        if controller.index + 1 < numberOfScopes {
            return getViewController(controller.index + 1)
        }
        
        return nil
    }
    
    private func getViewController(index: Int) -> ScopeTableViewController? {
        
        if index < numberOfScopes {
            
            let scopeTableViewController = ScopeTableViewController()
            
            scopeTableViewController.index = index
            scopeTableViewController.data = scopeController.filteredDataForScope(scopeController.scopes()[index])
            
            return scopeTableViewController
        }
        
        return nil
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
