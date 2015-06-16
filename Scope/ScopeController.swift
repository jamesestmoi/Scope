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
    func dataForScope(scope: Scope) -> [AnyObject]
    func customizeTableView(inout tableView: UITableView!)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, andScope scope: Scope) -> UITableViewCell
}

let barHeight: CGFloat = 88

class ScopeController: UIViewController, ScopeControllerDelegate {
    
    var barView: ScopeBarView!
    var containerView: ScopeContainerView!
    var tableView: UITableView!

    override func viewDidLoad() {

        barView = ScopeBarView(scopes: scopes(), scopeController: self)
        containerView = ScopeContainerView(scopeController: self)
        
        view.addSubview(barView)
        view.addSubview(containerView)
        
        layout(barView, containerView, view) { (bar, container, view) -> () in
            
            bar.top == view.top
            bar.left == view.left
            bar.right == view.right
            bar.height == barHeight
            
            container.top == bar.bottom
            container.left == view.left
            container.right == view.right
            container.bottom == view.bottom
        }
        
        //containerView.scrollView.contentSize = CGSizeMake(containerView.frame.width * CGFloat(scopes().count), containerView.frame.height)
        //barView.scrollView.contentSize = CGSizeMake((barView.frame.width / 3) * (CGFloat(scopes().count + 2)), barView.frame.height)
        
        let testView = UIView(frame: containerView.scrollView.bounds)
        testView.backgroundColor = UIColor.redColor()
        
        
        //containerView.scrollView.addSubview(testView)
        
        /*layout(testView, containerView.scrollView) { (view, superview) -> () in
            
            view.top == superview.top
            view.bottom == superview.bottom
            view.right == superview.right
            view.left == superview.left
            
            //view.edges == inset(superview.edges, 0, self.scrollView.frame.width * CGFloat(index), 0, 0)
        }*/
        
        super.viewDidLoad()
    }

    func scopes() -> [Scope] {
        return [Scope]()
    }
    
    func dataForScope(scope: Scope) -> [AnyObject] {
        return [AnyObject]()
    }
    
    func customizeTableView(inout tableView: UITableView!) {
        tableView.backgroundColor = UIColor.grayColor()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int, andScope scope: Scope) -> Int {
        return dataForScope(scope).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, andScope scope: Scope) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func centerView(sender: ScopeBarItemView) {
        barView.centerBarItem(sender)
        containerView.centerViewControllerWithIndex(sender.index)
    }
}
