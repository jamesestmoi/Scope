//
//  ViewController.swift
//  Scope
//
//  Created by James Pickering on 6/13/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class ViewController: ScopeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scopes() -> [Scope] {
        
        let allScope = Scope(title: "ALL", imageNamed: "nil", query: "")
        let kanyeScope = Scope(title: "KANYE", imageNamed: "nil", query: "Kanye West")
        
        return [allScope, kanyeScope]
    }
    
    override func data() -> [AnyObject] {
        
        return ["Kanye West", "Jay Z", "2 Chainz"]
    }

    override func filteredDataForScope(scope: Scope) -> [AnyObject] {
        
        if scope.query as! String == "" {
            return data()
        }
        
        return data().filter { (d) -> Bool in
            return d as! String == scope.query as! String
        }
    }
}

