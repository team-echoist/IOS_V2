//
//  DependenciesViewControllerType.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/22.
//  Copyright © 2020 Foodinko. All rights reserved.
//


import UIKit


public protocol DependenciesViewControllerType {
    
    func makeMain() -> UIViewController
    func makeMainTabBar() -> UIViewController
    func makeWriting() -> UIViewController
}
