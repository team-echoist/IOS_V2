//
//  UIViewController+NavigationBarTransparent.swift
//  
//
//  Created by 정윤호 on 2017. 3. 29..
//  Copyright © 2017년 Foodinko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func navigationBarTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        self.navigationController?.view.backgroundColor = .clear
    }
}
