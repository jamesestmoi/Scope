//
//  ViewController.swift
//  Scope
//
//  Created by James Pickering on 6/13/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class ViewController: ScopeController {
    
    let data = ["Kanye West", "Jay Z", "2 Chainz"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func scopes() -> [Scope] {
        
        let allScope = Scope(title: "ALL", imageNamed: "nil", query: "")
        let kanyeScope = Scope(title: "KANYE", imageNamed: "nil", query: "Kanye West")
        
        return [allScope, kanyeScope]
    }
    
    override func dataForScope(scope: Scope) -> [AnyObject] {
        
        if scope.query as! String == "" {
            return data
        }
        
        return data.filter { (d) -> Bool in
            return d as String == scope.query as! String
        }
    }
    
    override func customizeTableView(inout tableView: UITableView!) {
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, andScope scope: Scope) -> UITableViewCell {
        
        let d = dataForScope(scope)
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        let name = d[indexPath.row] as! String
        
        cell.textLabel!.text = name
        
        return cell
    }
}

