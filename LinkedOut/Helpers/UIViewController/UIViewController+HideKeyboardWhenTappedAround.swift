//
//  UIViewController+HideKeyboardWhenTappedAround.swift
//  
//
//  Created by 정윤호 on 2017. 8. 19..
//  Copyright © 2017년 Foodinko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: UIGestureRecognizerDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardWhenTappedAround))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardWhenTappedAround() {
        view.endEditing(true)
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // UI Button이면 제스쳐 동작 x
        if let touchView = touch.view, touchView is UIButton {
            return false
        }
        
        return true
    }
}
