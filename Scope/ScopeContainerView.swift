//
//  ScopeContainerView.swift
//  Scope
//
//  Created by James Pickering on 6/13/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit
import Cartography

class ScopeContainerView: UIView, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var scopeController: ScopeController!
    var views = [UIView]()
    var viewControllers = [UIViewController]()
    var numberOfScopes: Int {
        get {
            return scopeController.scopes().count
        }
    }
    var currentPage: Double = 0
    var shouldAnimateBar = true
    
    init(scopeController: ScopeController) {
        
        self.scopeController = scopeController
        
        self.scrollView = UIScrollView()
        
        super.init(frame: CGRectZero)
        
        self.scrollView.decelerationRate = 0.00000001
        self.scrollView.pagingEnabled = false
        self.scrollView.delegate = self
    
        addSubview(scrollView)

        if numberOfScopes > 0 {
            let first = getViewController(0)
            addViewControllerToScrollView(first!)
        }
        
        scrollView.backgroundColor = UIColor.orangeColor()
        
        for i in 0..<numberOfScopes {
            let v = getViewController(i)!
            v.view.backgroundColor = UIColor(white: CGFloat(i) / 5.0, alpha: 1.0)
            scrollView.addSubview(v.view)
            viewControllers.append(v)
            views.append(v.view)
            scopeController.addChildViewController(v)
            v.didMoveToParentViewController(scopeController)
        }
        
        layout(scrollView, self) { (scroll, superview) -> () in
            scroll.left == superview.left
            scroll.right == superview.right
            scroll.top == superview.top
            scroll.bottom == superview.bottom
        }
        
        let width = UIScreen.mainScreen().bounds.width
        
        layout(views, { (views) -> () in
            
            views[0].left == views[0].superview!.left
            views[0].top == views[0].superview!.top
            views[0].bottom == views[0].superview!.superview!.bottom
            views[0].width == width
            views[0].right == views[1].left
            
            for i in 1...views.count - 2 {
                views[i].top == views[i].superview!.top
                views[i].bottom == views[i].superview!.superview!.bottom
                views[i].right == views[i + 1].left
                views[i].width == width
            }
            
            views[views.count - 1].right == views[views.count - 1].superview!.right
            views[views.count - 1].bottom == views[views.count - 1].superview!.superview!.bottom
            views[views.count - 1].top == views[views.count - 1].superview!.top
            views[views.count - 1].width == width
        })
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
            scopeTableViewController.scopeController = scopeController
            
            return scopeTableViewController
        }
        
        return nil
    }
    
    func addViewControllerToScrollView(viewController: ScopeTableViewController) {
        
        // scrollView.addSubview(viewController.tableView)
        
        scopeController.addChildViewController(viewController)
        viewController.didMoveToParentViewController(scopeController)
        
        let testView = UIView(frame: CGRectZero)
        testView.backgroundColor = UIColor.redColor()
        
        scrollView.addSubview(testView)
        
        layout(testView, scrollView, scrollView) { (view, superview, scrollview) -> () in
            
            view.top == superview.top
            view.bottom == superview.bottom
            view.right == superview.right
            view.left == superview.left
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if shouldAnimateBar == true {
            let item = scopeController.barView.views[Int(currentPage)]
            let relativeContainerOffsetX = scrollView.contentOffset.x - scrollView.frame.width * CGFloat(currentPage)
            let relativeBarOffsetX = relativeContainerOffsetX / 3.0
            let barOffsetX = relativeBarOffsetX + (scrollView.frame.width / 3 * CGFloat(currentPage))
            scopeController.barView.scrollView.setContentOffset(CGPointMake(barOffsetX, 0), animated: false)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        shouldAnimateBar = true
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.width
        
        currentPage = floor(Double((scrollView.contentOffset.x - pageWidth / 2) / pageWidth)) + 1
        
        println("Dragging - you are on page \(currentPage)")
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = scrollView.frame.width
        
        var newPage = currentPage
        
        if velocity.x == 0 {
            newPage = floor(Double((targetContentOffset.memory.x - pageWidth / 2) / pageWidth)) + 1
        }
        else {
            newPage = velocity.x > 0 ? currentPage + 1 : currentPage - 1
        }
        
        if newPage < 0 {
            newPage = 0
        }
        
        if newPage > Double(scrollView.contentSize.width / pageWidth) {
            newPage = ceil(Double(scrollView.contentSize.width / pageWidth)) - 1.0
        }
        
        targetContentOffset.memory = CGPointMake(CGFloat(newPage) * pageWidth, targetContentOffset.memory.y)
    }
    
    func centerViewControllerWithIndex(index: Int) {
        let vc = viewControllers[index]
        let view = vc.view
        
        shouldAnimateBar = false
        scrollView.setContentOffset(CGPoint(x: view.center.x - scrollView.frame.width / 2, y: 0), animated: true)
    }

}
