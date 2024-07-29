//
//  UIViewController+ChildAddRemove.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import UIKit


extension UIViewController {
    
    /// Add child view controller
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        self.addChild(child)
        child.view.frame = (frame == nil) ? self.view.bounds : frame!
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// Remove child view controller
    func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
}
