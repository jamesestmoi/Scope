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

class ScopeController: UIViewController, ScopeControllerDelegate {
    
    var barView: ScopeBarView!
    var containerView: ScopeContainerView!
    var tableView: UITableView!

    override func viewDidLoad() {

        barView = ScopeBarView(scopes: scopes())
        containerView = ScopeContainerView(scopeController: self)
        
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
}
