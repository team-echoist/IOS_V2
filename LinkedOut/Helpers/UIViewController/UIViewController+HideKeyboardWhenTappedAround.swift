//
//  UIViewController+HideKeyboardWhenTappedAround.swift
//  
//
//  Created by 정윤호 on 2017. 8. 19..
//  Copyright © 2017년 Foodinko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardWhenTappedAround))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardWhenTappedAround() {
        view.endEditing(true)
    }
}
