//
//  ScopeBarView.swift
//  
//
//  Created by James Pickering on 6/13/15.
//
//

import UIKit
import Cartography

class ScopeBarView: UIView {
    
    var views = [UIView]()
    var scrollView: UIScrollView = UIScrollView()
    var scopeController: ScopeController!
    
    init(scopes: [Scope], scopeController: ScopeController) {
        super.init(frame: CGRectZero)
        
        addSubview(scrollView)
        
        scrollView.backgroundColor = UIColor.orangeColor()
        
        let front = ScopeBarItemEmptyView()
        scrollView.addSubview(front)
        
        views.append(front)
        
        for i in 0..<scopes.count {
            let v = ScopeBarItemView(title: scopes[i].title, imageNamed: "", barView: self, index: i)
            v.backgroundColor = UIColor(white: CGFloat(i) / 5.0, alpha: 1.0)
            scrollView.addSubview(v)
            views.append(v)
        }
        
        let back = ScopeBarItemEmptyView()
        scrollView.addSubview(back)
        
        views.append(back)
        
        layout(scrollView, self) { (scroll, view) -> () in
            
            scroll.width == view.width
            scroll.height == view.height
            scroll.center == view.center
        }
        
        let width = UIScreen.mainScreen().bounds.width / 3
        
        layout(views, { (views) -> () in
            
            views[0].left == views[0].superview!.left
            views[0].top == views[0].superview!.top
            views[0].height == barHeight
            views[0].width == width
            
            for i in 1...views.count - 2 {
                views[i].left == views[i - 1].right
                views[i].top == views[i].superview!.top
                views[i].height == barHeight
                views[i].right == views[i + 1].left
                views[i].width == width
            }
            
            views[views.count - 1].right == views[views.count - 1].superview!.right
            views[views.count - 1].height == barHeight
            views[views.count - 1].top == views[views.count - 1].superview!.top
            views[views.count - 1].width == width
        })
    }
    
    func centerBarItem(item: ScopeBarItemView) {
        
        scrollView.setContentOffset(CGPoint(x: item.center.x - scrollView.frame.width / 2, y: 0), animated: true)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
